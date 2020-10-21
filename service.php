<?php

use Apretaste\Request;
use Apretaste\Response;

class Service
{
	/* list of categories, must match the JS file */
	private $categories = [
		'professor' => 'Profesor',
		'design' => 'Diseño',
		'marketing' => 'Marketing',
		'coding' => 'Programación',
		'copywrite' => 'Escritura',
		'translation' => 'Traducción',
		'research' => 'Investigación',
		'testing' => 'Muestreo',
		'other' => 'Otro'];

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
		// get search filters, if exist
		$filters = [$this->categories['coding'], 'php'];

		// get all job offers
		$offers = [
			['id' => 123, 'title' => 'Busco programador de C++ para un trabajo super dificil ahi', 'category' => 'coding', 'inserted' => '2020-06-30 18:20:15'],
			['id' => 223, 'title' => 'Busco programador de JavaScript para un trabajo super dificil ahi', 'category' => 'coding', 'inserted' => '2020-06-30 18:20:15'],
			['id' => 323, 'title' => 'Busco programador de PHP para un trabajo super dificil ahi', 'category' => 'coding', 'inserted' => '2020-06-30 18:20:15'],
			['id' => 423, 'title' => 'Necesito un diseñador que sepa usar Photoshop sin lios', 'category' => 'coding', 'inserted' => '2020-06-30 18:20:15'],
		];

		// create content for the view
		$content = [
			'filters' => $filters, 
			'offers' => $offers, 
			'page' => 1, 
			'pages' => 3
		];

		// send data to the view
		$response->setTemplate("offers.ejs", $content);
	}

	/**
	 * View one especific job offer
	 */
	public function _job(Request $request, Response $response)
	{
		// get the job offer
		$job = [
			'id' => 12345,
			'title' => 'Busco programador de C++ para un trabajo super dificil ahi',
			'desc' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim.',
			'category' => 'coding',
			'inserted' => '2020-06-30 18:20:15',
		];

		// send data to the view
		$response->setTemplate("job.ejs", $job);
	}

	/**
	 * Show the form to insert a new job offer
	 */
	public function _newjob(Request $request, Response $response)
	{
		// send data to the view
		$response->setTemplate("newjob.ejs");
	}

	/**
	 * Save a new job offer
	 */
	public function _savejob(Request $request, Response $response)
	{
		$response->setTemplate('message.ejs', [
			'header' => 'Oferta creada',
			'icon' => 'thumb_up',
			'text' => 'Su oferta laboral se ha creado correctamente, y pronto deberá recibir peticiones de trabajo. Los interesados le contactarán a través del correo electrónico.',
			'btnLink' => 'TRABAJOS OFFERS',
			'btnCaption' => 'Ofertas']);
	}

	/**
	 * Edit your currirulum
	 */
	public function _curriculum(Request $request, Response $response)
	{
		// get professional name
		// NOTE: should be different from the platform's name
		$name = 'Salvador Pascual';

		// get the person's bio
		$bio = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim';

		// get the list of person's professions
		$professions = ['coding', 'professor'];

		// get the person's ecucation
		$education = [
			['id' => 1234, 'grad_year' => '2004', 'school' => 'Osvaldo Herrera', 'degree' => 'Técnico Medio en Electrónica'],
			['id' => 2234, 'grad_year' => '2006', 'school' => 'Instituto Superior Politécnico José Antonio Echevarría', 'degree' => 'Ingeniero Informático'],
			['id' => 3234, 'grad_year' => '', 'school' => 'Florida International University', 'degree' => 'Master in Computer Science'],
		];

		// get the person's experience
		$experience = [
			['id' => 1234, 'workplace' => 'Instituto de la Educación Internacional', 'position' => 'Programador Principal'],
			['id' => 2234, 'workplace' => 'Unirsidad Espectacular', 'position' => 'Profesor de Ciencias'],
		];

		// get the person's profesional skills
		$skills = ['php', 'JavaScript', 'Apache2', 'Zoom', 'Photoshop', 'Illustrator', 'Google Analytics'];

		// create content for the view
		$content = [
			'name' => $name,
			'bio' => $bio,
			'professions' => $professions,
			'education' => $education,
			'experience' => $experience,
			'skills' => $skills
		];

		// send data to the view
		$response->setTemplate("curriculum.ejs", $content);
	}

	/**
	 * Delete an education or experiencie from the user curriculum
	 */
	public function _delete(Request $request, Response $response)
	{
		// get data to create a comment
		$id = $request->input->data->id;
		$type = $request->input->data->type;

		// delete the education or experiencie
		// TODO
	}

	/**
	 * List of people
	 */
	public function _people(Request $request, Response $response)
	{
		// get search filters, if exist, else should be false
		$filters = 'design';

		// get the list of people
		$workers = [
			['id' => 1234, 'name' => 'Jhon Jonson', 'categories' => ['coding', 'copywrite', 'professor']],
			['id' => 2234, 'name' => 'Tom Thomas', 'categories' => ['marketing', 'translation']],
			['id' => 3234, 'name' => 'Peter Parker', 'categories' => ['testing', 'copywrite', 'design']],
		];

		// create content for the view
		$content = [
			'filters' => $filters,
			'workers' => $workers,
			'page' => 1, 
			'pages' => 3
		];

		// send data to the view
		$response->setTemplate("people.ejs", $content);
	}

	/**
	 * View someone's currirulum
	 */
	public function _profile(Request $request, Response $response)
	{
		// get professional name
		$name = 'Salvador Pascual';

		// get the person's bio
		$bio = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim';

		// get the person's professions
		$professions = 'Profesor, Diseño';

		// get the person's ecucation
		$education = [
			['grad_year' => '2004', 'school' => 'Osvaldo Herrera', 'degree' => 'Técnico Medio en Electrónica'],
			['grad_year' => '2006', 'school' => 'Instituto Superior Politécnico José Antonio Echevarría', 'degree' => 'Ingeniero Informático'],
			['grad_year' => '', 'school' => 'Florida International University', 'degree' => 'Master in Computer Science'],
		];

		// get the person's experience
		$experience = [
			['workplace' => 'Instituto de la Educación Internacional', 'position' => 'Programador Principal'],
			['workplace' => 'Unirsidad Espectacular', 'position' => 'Profesor de Ciencias'],
		];

		// get the person's profesional skills
		$skills = 'php, JavaScript, Apache2, Zoom, Photoshop, Illustrator';

		// get the person's languages and proficiency
		$languages = 'Francés, Español';

		// create content for the view
		$content = [
			'id' => $request->person->id,
			'name' => $name,
			'bio' => $bio,
			'professions' => $professions,
			'education' => $education,
			'experience' => $experience,
			'skills' => $skills
		];

		// send data to the view
		$response->setTemplate("profile.ejs", $content);
	}

	/**
	 * Chat between creators and applicants
	 */
	public function _chat(Request $request, Response $response)
	{
		// get the list of chats
		$chats = [
			['position' => 'right', 'name' => 'Maria Fernandez', 'inserted' => '2020-10-20 3:34:12', 'comment' => 'Hola. ¿Aún está abierta la posicion?'],
			['position' => 'left', 'name' => 'Pedro Cansoas', 'inserted' => '2020-10-20 3:34:12', 'comment' => 'Sí, necesitamos un programador'],
			['position' => 'right', 'name' => 'Maria Fernandez', 'inserted' => '2020-10-20 3:34:12', 'comment' => '¿El trabajo es desde casa o en persona?'],
		];

		// get your name and id
		$from = [
			'id' => 2234,
			'name' => 'Maria Fernandez',
		];

		// get the other person's name and id
		$to = [
			'id' => 1234,
			'name' => 'Pedro Cansoas',
		];

		// create content for the view
		$content = [
			'chats' => $chats,
			'from' => $from,
			'to' => $to
		];

		// send data to the view
		$response->setTemplate('chat.ejs', $content);
	}

	/**
	 * Post a comment in the chat
	 */
	public function _comment(Request $request, Response $response)
	{
		// get data to create a comment
		$toId = $request->input->data->to;
		$message = $request->input->data->message;

		// save the message to the database
		// TODO

		// send a push notification to the other user
		// TODO
	}
}
