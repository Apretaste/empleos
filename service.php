<?php

class Trabajos extends Service
{

	/**
	 * Function executed when the service is called
	 *
	 * @param Request $request
	 * @return Response
	 */
	public function _main(Request $request)
	{
		$cv = $this->getCV($request->email);

		$r = Connection::query("SELECT count(*) as total FROM _note WHERE to_user = '{$request->email}' AND read_date is null;");
		$cv->messages_count = $r[0]->total * 1;

		$r = Connection::query("SELECT count(*) as total FROM _trabajos_cv WHERE email = '{$request->email}';");
		$cv->jobs = $r[0]->total * 1;

		$response = new Response();
		$response->setEmailLayout('layout.tpl');
		$response->createFromTemplate('home.tpl', [
			"username" => $request->username,
			"cv" => $cv
		]);

		return $response;
	}

	public function _agregar($request)
	{
		$title = trim($request->query);
		$id = Connection::query("INSERT INTO _trabajos_job (email, title) VALUES ('{$request->email}','{$title}');");
		$request->query = $id;
		return $this->_trabajo($request);
	}

	/**
	 * @param $request
	 * @return Response
	 */
	public function _trabajo($request)
	{
		$id = intval(trim($request->query));
		$job = Connection::query("SELECT *, 
					(SELECT profession FROM _trabajos_cv_professions 
						WHERE _trabajos_cv_professions.id = _trabajos_job.looking_for_profession) as looking 
					FROM _trabajos_job WHERE id = '$id';");

		if (!isset($job[0]))
			return new Response();

		$job = $job[0];

		$job->username = $this->utils->getUsernameFromEmail($job->email);
		$response = new Response();

		$tpl = 'job';
		if ($job->email == $request->email) $tpl = 'job_edit';

		$response->setEmailLayout('layout.tpl');
		$response->createFromTemplate("$tpl.tpl", [
			'job' => $job,
			'professions' => $this->getProfessionsInline()
		]);

		return $response;
	}

	public function _ofertas($request)
	{

		$jobs = Connection::query("SELECT * FROM _trabajos_job WHERE email = '{$request->email}';");

		$response = new Response();
		$response->setEmailLayout('layout.tpl');
		$response->createFromTemplate('jobs_list.tpl', [
			"jobs" => $jobs
		]);

		return $response;
	}

	public function _descripcion($request)
	{
		$desc = trim($request->query);
		Connection::query("UPDATE _trabajos_cv SET description = '$desc' WHERE email = '{$request->email}';");
		$request->query = '';
		return $this->_editar($request);
	}

	public function _editar($request)
	{
		$q = trim($request->query);
		if ($q != '') {
			$parts = explode(' ', $q);
			$tabla = trim(strtolower($parts[0]));
			$id = trim(strtolower($parts[1]));
			$campo = trim(strtolower($parts[2]));

			array_shift($parts);
			array_shift($parts);
			array_shift($parts);

			$valor = implode(' ', $parts);

			$map = [
				'educacion' => '_trabajos_cv_education',
				'experiencia' => '_trabajos_cv_experience',
				'habilidad' => '_trabajos_cv_skills',
				'idioma' => '_trabajos_cv_langs',
				'oferta' => '_trabajos_job'
			];

			$fieldMap = [
				'desde' => 'start_year',
				'hasta' => 'end_year',
				'ocupacion' => 'title',
				'titulo' => 'title',
				'compania' => 'company',
				'escuela' => 'school',
				'graduacion' => 'graduation_year',
				'detalles' => 'details',
				'descripcion' => 'description',
				'buscando' => 'looking_for_profession',
				'details' => 'detalles'
			];

			if (isset($map[$tabla]) && isset($fieldMap[$campo])) {

				switch($campo)
				{
					case 'buscando':
						Connection::query("UPDATE {$map[$tabla]} SET {$fieldMap[$campo]} = (SELECT id from _trabajos_cv_professions WHERE profession = '{$valor}') WHERE id = $id;");
						break;
					default:
						$valor = Connection::escape($valor);
						Connection::query("UPDATE {$map[$tabla]} SET {$fieldMap[$campo]} = '{$valor}' WHERE id = $id;");
						break;
				}

				switch ($tabla) {
					case 'oferta':
						$request->query = $id;
						return $this->_trabajo($request);
					default:
						$request->query = '';
						return $this->_editar($request);
				}
			}
		}

		$professions = [];
		$r = Connection::query("SELECT * FROM _trabajos_cv_professions;");
		foreach ($r as $item)
			$professions[] = $item->profession;

		$response = new Response();
		$profile = $this->utils->getPerson($request->email);
		$cv = $this->getCV($request->email);
		$cv->province = str_replace('_', ' ', $cv->province);

		$response->setEmailLayout('layout.tpl');
		$response->createFromTemplate('profile_edit.tpl', [
			'profile' => $profile,
			'cv' => $cv,
			'professions' => $this->getProfessionsInline(),
			'provinces' => str_replace('_', ' ', implode(',', ['PINAR_DEL_RIO', 'LA_HABANA', 'ARTEMISA', 'MAYABEQUE', 'MATANZAS', 'VILLA_CLARA', 'CIENFUEGOS', 'SANCTI_SPIRITUS', 'CIEGO_DE_AVILA', 'CAMAGUEY', 'LAS_TUNAS', 'HOLGUIN', 'GRANMA', 'SANTIAGO_DE_CUBA', 'GUANTANAMO', 'ISLA_DE_LA_JUVENTUD']))
		]);

		return $response;
	}

	public function _perfil($request)
	{
		$username = trim($request->query);

		$email = $this->utils->getEmailFromUsername($username);

		if ($email === false)
			return new Response();

		if ($email != $request->email)
			Connection::query("UPDATE _trabajos_cv SET views = views + 1 WHERE email = '$email';");

		$cv = $this->getCV($email);
		$profile = $this->utils->getPerson($email);

		$response = new Response();
		$response->setEmailLayout('layout.tpl');
		$response->createFromTemplate('profile.tpl', [
			'cv' => $cv,
			'profile' => $profile
		]);
		return $response;
	}

	public function _nombre($request)
	{
		$name = trim(ucfirst($request->query));
		if ($name !== '') {
			$this->createCV($request->email);
			Connection::query("UPDATE _trabajos_cv SET full_name = '$name' WHERE email = '{$request->email}';");
			$request->query = '';
			return $this->_editar($request);
		}

		return new Response();
	}

	public function _profesion($request)
	{
		$q = trim(ucfirst($request->query));
		$p = strpos($q, ' ');
		$n = trim(substr($q, 0, $p));
		$q = trim(substr($q, $p));
		$q = strtoupper($q);
		$q = html_entity_decode($q);
		$q = htmlentities($q);
		Connection::query("UPDATE _trabajos_cv SET profession{$n} = (SELECT id FROM _trabajos_cv_professions WHERE profession ='$q');");
		$request->query = '';
		return $this->_editar($request);
	}

	public function _educacion($request)
	{
		$q = trim($request->query);
		$data = explode(' ', $q);
		$year = intval($data[0]);
		$title = trim(substr($q, strlen($year)));

		$q = "INSERT INTO _trabajos_cv_education (email, graduation_year, title) VALUES ('{$request->email}','{$year}', '{$title}');";
		Connection::query($q);
		$request->query = '';
		return $this->_editar($request);
	}

	public function _experiencia($request)
	{
		$q = trim($request->query);
		$data = explode(' ', $q);
		$year = intval($data[0]);
		$title = trim(substr($q, strlen($year)));
		$q = "INSERT INTO _trabajos_cv_experience (email, start_year, title) VALUES ('{$request->email}','{$year}', '{$title}');";
		Connection::query($q);
		$request->query = '';
		return $this->_editar($request);
	}

	/**
	 * Subservice HABILIDAD
	 *
	 * @param $request
	 * @return Response
	 */
	public function _habilidad($request)
	{
		$q = trim($request->query);
		if ($q != '') {
			$q = "INSERT INTO _trabajos_cv_skills (email, skill) VALUES ('{$request->email}','{$q}');";
			Connection::query($q);
			$request->query = '';
			return $this->_editar($request);
		}

		return new Response();
	}

	public function _idioma($request)
	{
		$q = trim($request->query);
		$data = explode(' ', $q);

		$q = "INSERT INTO _trabajos_cv_langs (email, lang, lang_level) 
				VALUES ('{$request->email}','{$data[0]}', '{$data[1]}');";

		Connection::query($q);
		$request->query = '';
		return $this->_editar($request);
	}

	public function _quitar($request)
	{
		$q = trim($request->query);
		$what = explode(' ', $q);
		$what = strtolower($what[0]);
		$p = strpos($q, ' ');

		if ($p === false) return new Response();

		$q = trim(substr($q, $p));
		$id = intval(trim($q));

		$map = [
			'educacion' => '_trabajos_cv_education',
			'experiencia' => '_trabajos_cv_experience',
			'habilidad' => '_trabajos_cv_skills',
			'idioma' => '_trabajos_cv_langs'
		];

		if (isset($map[$what])) {
			Connection::query("DELETE FROM {$map[$what]} WHERE id = $id;");
		}

		$request->query = '';
		return $this->_editar($request);
	}

	public function _provincia($request)
	{
		$prov = str_replace(' ', '_', strtoupper(trim($request->query)));
		Connection::query("UPDATE _trabajos_cv SET province = '$prov' WHERE email = '{$request->email}';");
		$request->query = '';
		return $this->_editar($request);
	}

	public function _buscar($request)
	{
		$words = $this->getWords($request->query);
		$where = '';
		foreach ($words as $w)
			$where .= "concat(coalesce(title,''), ' ', coalesce(details,''), ' ', coalesce(looking_for_profession,''), ' ', coalesce(contract,''), ' ',coalesce(job_level,'')) LIKE '%{$w}%' AND ";

		$where .= 'TRUE';

		$q = "SELECT *, datediff(CURRENT_DATE, coalesce(end_date, CURRENT_DATE)) as days FROM _trabajos_job WHERE end_date <= CURRENT_DATE $where;";

		$jobs = Connection::query($q);
		$response = new Response();
		$response->setEmailLayout('layout.tpl');
		$response->createFromTemplate('search_job.tpl', [
			'jobs' => $jobs
		]);
		return $response;
	}

	public function _reclutar($request)
	{
		$r = Connection::query("SELECT * FROM _trabajos_cv_professions");
		$professions = [];
		foreach ($r as $prof)
			$professions[$prof->id] = $prof->profession;
		$words = $this->getWords($request->query);
		$where = '';

		foreach ($words as $w)
			$where .= "concat(coalesce((SELECT profession FROM _trabajos_cv_professions WHERE _trabajos_cv_professions.id = profession1),''), 
					     ' ', coalesce((SELECT profession FROM _trabajos_cv_professions WHERE _trabajos_cv_professions.id = profession2),''), 
					     ' ', coalesce((SELECT profession FROM _trabajos_cv_professions WHERE _trabajos_cv_professions.id = profession3),''), 
					     ' ', coalesce(description, ''), ' ',coalesce(province,'')) LIKE '%{$w}%' AND ";
		$where .= 'TRUE';


		$q = "SELECT *, datediff(CURRENT_DATE, coalesce(concat((SELECT min(start_year) FROM _trabajos_cv_experience WHERE _trabajos_cv_experience.email = _trabajos_cv.email),'-01-01'), CURRENT_DATE)) /365 as experience_years FROM _trabajos_cv WHERE $where;";
		//echo $q;
		$cvs = Connection::query($q);

		foreach ($cvs as $k => $cv) {
			$profile = $this->utils->getPerson($cv->email);
			$cvs[$k]->profile = $profile;
			$cvs[$k]->experience_years = intval($cvs[$k]->experience_years);
		}

		$response = new Response();
		$response->setEmailLayout('layout.tpl');
		$response->createFromTemplate('search_cv.tpl', [
			'cvs' => $cvs
		]);
		return $response;
	}

	private function getWords($text)
	{
		$q = trim(strtolower($text));
		$words = [];
		$q = explode(' ', $q);
		foreach ($q as $w) {
			$w = trim($w);
			if ($w != '')
				$words[$w] = $w;
		}
		return $words;
	}

	private function getCV($email)
	{
		$profile = $this->utils->getPerson($email);

		Connection::query("INSERT IGNORE INTO _trabajos_cv (email) VALUES ('$email');");
		$cv = Connection::query("SELECT *,
									(SELECT profession FROM _trabajos_cv_professions WHERE id = _trabajos_cv.profession1) as profession1_title,
									(SELECT profession FROM _trabajos_cv_professions WHERE id = _trabajos_cv.profession2) as profession2_title,
									(SELECT profession FROM _trabajos_cv_professions WHERE id = _trabajos_cv.profession3) as profession3_title
 									FROM _trabajos_cv 
 									WHERE email = '$email';");

		if (isset($cv[0])) $cv = $cv[0];
		else $cv = new stdClass();

		$default_cv = [
			'full_name' => $profile->full_name,
			'profession1' => '',
			'profession2' => '',
			'profession3' => '',
			'description' => '',
			'province' => '',
			'educations' => [],
			'skills' => [],
			'experiences' => [],
			'professions' => [],
			'langs' => []
		];

		foreach ($default_cv as $prop => $value)
			if (!isset($cv->$prop)) $cv->$prop = $value;

		$experiencies = Connection::query("SELECT * FROM _trabajos_cv_experience WHERE email = '$email' ORDER BY start_year;");
		$educations = Connection::query("SELECT * FROM _trabajos_cv_education WHERE email = '$email' ORDER BY graduation_year;");
		$skills = Connection::query("SELECT * FROM _trabajos_cv_skills WHERE email = '$email' ORDER BY skill;");
		$langs = Connection::query("SELECT * FROM _trabajos_cv_langs WHERE email = '$email' ORDER BY lang;");

		$cv->experiences = $experiencies;
		$cv->educations = $educations;
		$cv->skills = $skills;
		$cv->langs = $langs;

		$force = 0;

		if (!empty($cv->description))
			$force += 30;
		if (!empty($cv->profession1) || !empty($cv->profession2) || !empty($cv->profession3))
			$force += 20;

		if (count($cv->educations) > 0)
			$force += 20;

		if (count($cv->experiences) > 0)
			$force += 20;

		if (count($cv->skills) > 0)
			$force += 20;

		if (count($cv->langs) > 0)
			$force += 20;

		$cv->force = $force;

		return $cv;
	}

	public function createCV($email)
	{
		Connection::query("INSERT IGNORE INTO _trabajos_cv (email) VALUES ('$email');");
	}

	private function getProfessionsInline()
	{
		$professions = [];
		$r = Connection::query("SELECT * FROM _trabajos_cv_professions;");
		foreach ($r as $item)
			$professions[] = $item->profession;

		return implode(',', $professions);
	}
}