<?php

use Apretaste\Person;
use Apretaste\Request;
use Apretaste\Response;
use Framework\Database;
use Framework\GoogleAnalytics;

class Service
{
	/* list of categories, must match the JS file */
	private $categories = [];

	/**
	 * Service constructor.
	 * @throws \Framework\Alert
	 */
	public function __construct()
	{
		$categories = Database::query("SELECT * FROM _empleos_categories;");
		$this->categories = [];
		foreach ($categories as $category) {
			$this->categories[$category->code] = $category->description;
		}
	}

	/**
	 * A possible home screen
	 */
	public function _main(Request $request, Response $response)
	{
		return $this->_offers($request, $response);
	}

	/**
	 * List all possible job offers
	 */
	public function _offers(Request $request, Response $response)
	{
		$limit = 10;
		$page = $request->input->data->page ?? 1;
		$offset = ($page - 1) * $limit;
		$category = $request->input->data->category ?? null;
		$title = $request->input->data->title ?? null;
		$kind = $request->input->data->kind ?? '*';
		$filters = [ucfirst($kind), $category, $title];

		$offers = Database::query("SELECT * FROM _empleos_offers 
		WHERE (category = '$category' OR '$category' = '') 
			AND ('$title' = '' OR title LIKE '%$title%')
			AND (kind = '$kind' OR '$kind' = '' OR '$kind' = '*') 
		ORDER BY inserted DESC LIMIT $offset,$limit;");

		$total = Database::queryFirst("SELECT COUNT(*) AS cnt FROM _empleos_offers")->cnt;

		$pages = intval($total / $limit) + ($total % $limit > 0 ? 1 : 0);

		// create content for the view
		$content = [
			'filters' => $filters,
			'offers' => $offers,
			'page' => $page,
			'pages' => $pages,
			'categories' => $this->categories
		];

		// send data to the view
		$response->setTemplate("offers.ejs", $content);
	}

	/**
	 * View one especific job offer
	 */
	public function _job(Request $request, Response $response)
	{
		$id = $request->input->data->id ?? null;

		$job = Database::queryFirst("SELECT * FROM _empleos_offers WHERE id = '$id';");

		if ($job) {
			$job->categories = $this->categories;
			return $response->setTemplate("job.ejs", $job);
		}

		$response->setTemplate('message.ejs', [
			"header" => "Oferta no encontrada",
			"icon" => "sentiment_very_dissatisfied",
			"text" => "No encontramos la oferta solicitada",
			"btnCaption" => "Anuncios",
			"btnLink" => "EMPLEOS"
		]);
	}

	/**
	 * Show the form to insert a new job offer
	 */
	public function _newjob(Request $request, Response $response)
	{
		// send data to the view
		$response->setTemplate("newjob.ejs", [
			'categories' => $this->categories,
			'email' => $request->person->email
		]);
	}

	/**
	 * Save a new job offer
	 */
	public function _savejob(Request $request, Response $response)
	{

		$title = Database::escape($request->input->data->title ?? '');
		$description = Database::escape($request->input->data->desc ?? '');
		$category = Database::escape($request->input->data->category ?? '');
		$email = Database::escape($request->input->data->email ?? '');
		$kind = Database::escape($request->input->data->kind ?? '');

		Database::query("INSERT INTO _empleos_offers (id, title, description, category, email, person_id, kind) 
		VALUES (uuid(), '$title', '$description', '$category', '$email', {$request->person->id},'$kind')");

		GoogleAnalytics::event('jobs_create', '');

		$response->setTemplate('message.ejs', [
			'header' => 'Oferta creada',
			'icon' => 'thumb_up',
			'text' => 'Su oferta laboral se ha creado correctamente, y pronto deberá recibir peticiones de trabajo. Los interesados le contactarán a través del correo electrónico.',
			'btnLink' => 'EMPLEOS OFFERS',
			'btnCaption' => 'Anuncios']);
	}

	/**
	 * Save curriculum
	 *
	 * @param Request $request
	 * @param Response $response
	 * @throws \Framework\Alert
	 */
	public function _save(Request $request, Response $response)
	{

		Database::query("INSERT IGNORE INTO _empleos_profile (person_id) VALUES ({$request->person->id});");

		// update name
		$name = $request->input->data->name ?? null;
		if ($name !== null) {
			$name = Database::escape($name);
			Database::query("UPDATE _empleos_profile SET name = '$name' WHERE person_id = {$request->person->id}");
			GoogleAnalytics::event('jobs_resume', 'name');
		}

		// update email
		$email = $request->input->data->email ?? null;
		if ($email !== null) {
			$email = Database::escape($email);
			Database::query("UPDATE _empleos_profile SET email = '$email' WHERE person_id = {$request->person->id}");
			GoogleAnalytics::event('jobs_resume', 'email');
		}

		// update phone
		$phone = $request->input->data->phone ?? null;
		if ($phone !== null) {
			$phone = Database::escape($phone);
			Database::query("UPDATE _empleos_profile SET phone = '$phone' WHERE person_id = {$request->person->id}");
			GoogleAnalytics::event('jobs_resume', 'phone');
		}

		// update bio
		$bio = $request->input->data->bio ?? null;
		if ($bio !== null) {
			$bio = Database::escape($bio);
			Database::query("UPDATE _empleos_profile SET bio = '$bio' WHERE person_id = {$request->person->id}");
			GoogleAnalytics::event('jobs_resume', 'bio');
		}

		$professions = $request->input->data->professions ?? null;
		if ($professions !== null) {

			// clean all professions
			Database::query("DELETE FROM _empleos_profile_professions WHERE person_id = {$request->person->id}");

			// insert new professions
			foreach ($professions as $profession) {
				if (!empty($profession)) {
					Database::query("INSERT INTO _empleos_profile_professions (id, person_id, profession) VALUES (uuid(), {$request->person->id}, '$profession');");
				}
			}

			GoogleAnalytics::event('jobs_resume', 'profession');
		}

		// skills
		$skills = $request->input->data->skills ?? null;
		if ($skills !== null) {
			$skills = trim($skills);
			$skills = explode(',', $skills);

			// clean all skills
			Database::query("DELETE FROM _empleos_profile_skills WHERE person_id = {$request->person->id}");

			// insert new skill
			foreach ($skills as $skill) {
				$skill = strtolower(trim($skill));

				if (!empty($skill)) {
					Database::query("INSERT INTO _empleos_profile_skills (id, person_id, skill) VALUES (uuid(), {$request->person->id}, '$skill');");
				}
			}

			GoogleAnalytics::event('jobs_resume', 'skills');
		}
		$this->_curriculum($request, $response);
	}

	/**
	 * Save new education
	 *
	 * @param Request $request
	 * @param Response $response
	 * @throws \Framework\Alert
	 */
	public function _education(Request $request, Response $response)
	{

		$grad_year = intval(Database::escape($request->input->data->grad_year ?? 0));
		$degree = Database::escape($request->input->data->degree ?? null);
		$school = Database::escape($request->input->data->school ?? null);

		Database::query("INSERT INTO _empleos_profile_education (id, person_id, grad_year, school, degree) 
						 VALUES (uuid(), {$request->person->id}, $grad_year, '$degree', '$school');");

		GoogleAnalytics::event('jobs_resume', 'education');

		$this->_curriculum($request, $response);
	}


	/**
	 * Save new experience
	 *
	 * @param Request $request
	 * @param Response $response
	 * @throws \Framework\Alert
	 */
	public function _experience(Request $request, Response $response)
	{

		$workplace = Database::escape($request->input->data->workplace ?? null);
		$position = Database::escape($request->input->data->position ?? null);

		Database::query("INSERT INTO _empleos_profile_experience (id, person_id, workplace, position) 
						 VALUES (uuid(), {$request->person->id}, '$workplace', '$position');");

		GoogleAnalytics::event('jobs_resume', 'workplace');

		$this->_curriculum($request, $response);
	}

	/**
	 * @param $text
	 * @return string|string[]|null
	 */
	private function emailize($text)
	{
		$regex = '/(\S+@\S+\.\S+)/';
		$replace = '<a href="mailto:$1">$1</a>';

		return preg_replace($regex, $replace, $text);
	}

	/**
	 * Edit your curriculum
	 *
	 * @param Request $request
	 * @param Response $response
	 * @throws \Framework\Alert
	 */
	public function _curriculum(Request $request, Response $response)
	{
		$curriculum = $this->getCurriculum($request->person->id);
		$curriculum->categories = $this->categories;
		$response->setTemplate("curriculum.ejs", $curriculum);
	}

	/**
	 * Delete an education or experience from the user curriculum
	 * @param Request $request
	 * @param Response $response
	 */
	public function _delete(Request $request, Response $response)
	{
		// get data to create a comment
		$id = $request->input->data->id;
		$type = $request->input->data->type;

		if (in_array($type, ['education', 'experience'])) {
			Database::query("DELETE FROM _empleos_profile_$type WHERE id = '$id'");
		}

		$this->_curriculum($request, $response);
	}

	/**
	 * List of people
	 */
	public function _people(Request $request, Response $response)
	{
		// get search filters, if exist, else should be false
		$filters = [$request->input->data->category ?? ''];
		$limit = 10;
		$page = $request->input->data->offset ?? 1;
		$offset = ($page - 1) * $limit;

		// get the list of people
		$workers = Database::query("SELECT person_id as id, name FROM _empleos_profile 
		WHERE (('{$filters[0]}' = '') OR EXISTS(SELECT * FROM _empleos_profile_professions 
				WHERE _empleos_profile.person_id = _empleos_profile_professions.person_id
		    	AND profession = '{$filters[0]}'))
			AND trim(coalesce(_empleos_profile.name,'')) <> '' 
			AND trim(coalesce(_empleos_profile.email,'')) <> ''
			AND EXISTS(SELECT id FROM _empleos_profile_professions 
				WHERE _empleos_profile.person_id = _empleos_profile_professions.person_id)
		LIMIT $offset,10");

		foreach ($workers as $worker) {
			$worker->categories = $this->getProfessions($worker->id);
		}

		$total = Database::queryFirst("SELECT COUNT(*) AS cnt FROM _empleos_profile")->cnt;

		$pages = intval($total / $limit) + ($total % $limit > 0 ? 1 : 0);

		// create content for the view
		$content = [
			'filters' => $filters,
			'workers' => $workers,
			'page' => $page,
			'pages' => $pages,
			'categories' => $this->categories
		];

		// send data to the view
		$response->setTemplate("people.ejs", $content);
	}

	/**
	 * View someone's currirulum
	 */
	public function _profile(Request $request, Response $response)
	{
		$id = $request->input->data->id ?? null;
		$curriculum = $this->getCurriculum($id);

		if ($request->input->appVersion >= 7.1 || $request->input->environment == 'web') {
			$curriculum->externalLinks = true;
			$curriculum->email = $this->emailize($curriculum->email);
		}

		if ($id === null) {
			return $response->setTemplate('message.ejs', [
				'header' => 'Perfil no encontrado',
				"icon" => "sentiment_very_dissatisfied",
				"text" => "No encontramos el perfil solicitado",
				"btnCaption" => "Anuncios",
				"btnLink" => "EMPLEOS"
			]);
		}
		$curriculum->categories = $this->categories;
		$response->setTemplate("profile.ejs", $curriculum);
	}

	/**
	 * @param $personId
	 * @param null $offerId
	 * @return mixed
	 * @throws \Framework\Alert
	 */
	private function getBetterName($personId, $offerId = null) {
		$cv = Database::queryFirst("SELECT name FROM _empleos_profile WHERE person_id = $personId");
		$name = 'Desconocido';
		if ($cv) {
			return $cv->name;
		} else {
			$profile = Person::find($personId);
			if (!empty($profile->fullName))
				$name = $profile->fullName;
		}

		if ($offerId !== null) {
			$offer = Database::queryFirst("SELECT title FROM _empleos_offers WHERE id = '$offerId'");
			if ($offer) {
				$name .= "({$offer->title})";
			}
		}

		return $name;
	}

	/**
	 * @param Request $request
	 * @return array
	 * @throws \Framework\Alert
	 */
	private function getProfessions($personId): array
	{
		// get the list of person's professions
		$r = Database::query("SELECT * FROM _empleos_profile_professions WHERE person_id = {$personId}");
		$professions = [];
		foreach ($r as $pro) $professions[] = $pro->profession;
		return $professions;
	}

	/**
	 * @param $personId
	 * @param bool $full
	 * @throws \Framework\Alert
	 */
	private function getCurriculum($personId, $full = true)
	{
		// get basic data
		$curriculum = Database::queryFirst("SELECT * FROM _empleos_profile WHERE person_id = {$personId}");

		if ($curriculum === null) {
			return (object) [
				'id' => $personId,
				'name' => '',
				'email' => '',
				'bio' => '',
				'professions' => [],
				'education' => [],
				'experience' => [],
				'skills' => [],
				'phone' => ''
			];
		}

		$name = $curriculum->name ?? '';
		$bio = $curriculum->bio ?? '';
		$email = $curriculum->email ?? '';
		$phone = $curriculum->phone ?? '';
		$professions = [];
		$education = [];
		$experience = [];
		$skills = [];

		// get full profile
		if ($full) {
			$professions = $this->getProfessions($personId);

			// get the person's ecucation
			$education = Database::query("SELECT * FROM _empleos_profile_education WHERE person_id = {$personId}");

			// get the person's experience
			$experience = Database::query("SELECT * FROM _empleos_profile_experience WHERE person_id = {$personId}");

			// get the person's profesional skills
			$r = Database::query("SELECT * FROM _empleos_profile_skills WHERE person_id = {$personId}");
			$skills = [];
			foreach ($r as $pro) $skills[] = $pro->skill;
		}

		return (object)[
			'id' => $personId,
			'name' => $name,
			'bio' => $bio,
			'email' => $email,
			'professions' => $professions,
			'education' => $education,
			'experience' => $experience,
			'skills' => $skills,
			'phone' => $phone
		];
	}
}
