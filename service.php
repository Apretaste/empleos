<?php

class Trabajos extends Service
{

	/**
	 * Function executed when the service is called
	 *
	 * @param Request $request
	 * @return Response
	 */
	public function _main (Request $request)
	{

		$cv = $this->getCV($request->email);

		if (is_null($cv))
		{
			$cv = new stdClass();

			// TODO: add custom fields here
		}

		$cv->force = $this->getCVForce($cv);
		$cv->messages_count = 0;
		$cv->views  = 0;
		$cv->jobs = 0;

		$response = new Response();

		$response->createFromTemplate('home.tpl', [
			"username" => $request->username,
			"cv" => $cv
		]);

		return $response;
	}

	public function _agregar($request)
	{
		$q = trim($request->query);
		$data = explode('|', $q);

		$q = "INSERT INTO trabajos_cv_job (email, title, details, name, phone, looking_for_profession, end_date, salary, contract, job_level) 
				VALUES ('{$request->email}','{$data[0]}', '{$data[1]}', '{$data[2]}', '{$data[3]}', '{$data[4]}', '{$data[5]}', '{$data[6]}', '{$data[7]}', '{$data[8]}', '{$data[9]}');";

		Connection::query($q);

		return new Response();
	}

	public function _editar($request)
	{
		$response = new Response();

		$profile = $this->utils->getPerson($request->email);

		$cv = Connection::query("SELECT * FROM _trabajos_cv WHERE email='{$request->email}'");
		if (!isset($cv[0])) $cv = new stdClass();

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

		foreach($default_cv as $prop => $value)
			if (!isset($cv->$prop)) $cv->$prop = $value;

		var_dump($profile);
		var_dump($cv);

		$response->createFromTemplate('profile_edit.tpl',[
			'profile' => $profile,
			'cv' => $cv
		]);

		return $response;
	}

	public function _nombre($request)
	{
		$name = trim(ucfirst($request->query));
		if ($name !== '')
		{
			Connection::query("UPADTE _trabajos_cv SET full_name = '$name' WHERE email = '{$request->email}';");
			return $this->_editar($request);
		}

		return new Response();
	}

	public function _educacion($request)
	{
		$q = trim($request->query);
		$data = @json_decode($q);
		if (is_object($data))
		{
			$q = "INSERT INTO trabajos_cv_education (email, graduation_year, school) 
				  VALUES ('{$request->email}','{$data->graduation_year}','{$data->school}');";

			Connection::query($q);
		}

		return new Response();
	}

	public function _experiencia($request)
	{
		$q = trim($request->query);
		$data = @json_decode($q);
		if (is_object($data))
		{
			$q = "INSERT INTO trabajos_cv_experience (email, start_year, end_year, title, company) 
					VALUES ('{$request->email}','{$data->start_year}','{$data->end_year}', '{$data->title}', '{$data->company}');";

			Connection::query($q);
		}

		return new Response();
	}

	public function _habilidad($request)
	{
		$q = trim($request->query);
		$data = @json_decode($q);
		if (is_object($data))
		{
			$q = "INSERT INTO trabajos_cv_skills (email, skill) 
					VALUES ('{$request->email}','{$data->skill}');";

			Connection::query($q);
		}

		return new Response();
	}

	public function _idioma($request)
	{
		$q = trim($request->query);
		$data = explode(' ', $q);

		$q = "INSERT INTO trabajos_cv_langs (email, lang, lang_level) 
				VALUES ('{$request->email}','{$data[0]}', '{$data[1]}');";

		Connection::query($q);

		return new Response();
	}

	public function _quitar($request)
	{
		$q = trim($request->query);
		$what = explode(' ', $q);
		$what = strtolower($what[0]);
		$p = strpos($q,' ');

		if ($p === false) return new Response();

		$q = trim(substr($q,$p));

		$id = explode($q,' ');
		$id = intval($id[0]);

		$map = [
			'educacion' => '_trabajos_cv_education',
			'experiencia' => '_trabajos_cv_experience',
			'habilidad' => '_trabajos_cv_skills',
			'idioma' => '_trabajos_cv_langs'
		];

		if (isset($map[$what]))
		{
			Connection::query("DELETE FROM $map[$what] WHERE id = $id;");
		}

		return new Response();
	}
	
	private function getCV($email)
	{
		$cv = Connection::query("SELECT *,
									(SELECT profession FROM _trabajos_cv_professions WHERE id = _trabajos_cv.profession1) as profession1_title,
									(SELECT profession FROM _trabajos_cv_professions WHERE id = _trabajos_cv.profession2) as profession2_title,
									(SELECT profession FROM _trabajos_cv_professions WHERE id = _trabajos_cv.profession3) as profession3_title
 									FROM _trabajos_cv 
 									WHERE email = '$email';");

		if (isset($cv[0]))
			return $cv[0];

		return null;
	}

	private function getCVForce($cv)
	{

	}

}