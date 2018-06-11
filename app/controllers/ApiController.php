<?php

namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;

class ApiController extends BaseController
{
	public function postUpdateConfig(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('ConfigController');
		$post = $request->getParsedBody();

		foreach ($post as $key => $val) {
			if ('csrf_name' !== $key && 'csrf_value' !== $key) {
				$val = $this->filterString($val);

				$c->updateConfig($key, $val);
			}
		}

		return json_encode('Config saved');
	}

	public function getUser(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('UserController');
		$id = $args['userId'];
		$op = $c->getUser($id);

		return json_encode($op);
	}

	public function getUserStatus(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('UserController');
		$id = $args['userId'];
		$op = $c->getUserAllowedStatus($id);

		return json_encode($op);
	}

	public function getUserTasks(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('UserController');
		$id = $args['userId'];
		$op = $c->getUserAllowedTasks($id);

		return json_encode($op);
	}

	public function postCreateUser(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('UserController');
		$post = $request->getParsedBody();
		$id = $this->filterString(strtolower($post['user_id']));
		$name = $this->filterString($post['user_name']);
		$email = $this->filterString($post['user_email']);
		$passwordAuto = $this->filterString($post['user_password_auto']);
		$roleId = $this->filterString($post['role_id']);
		$departmentId = $this->filterString($post['department_id']);

		if ('1' == $passwordAuto) {
			$password = $this->generateStrongRandomPassword(10);
		} else {
			$password = $this->filterString($post['user_password']);
		}

		$op = $c->postCreateUser($id, $name, $email, $password, $roleId, $departmentId);

		return json_encode($op);
	}

	public function getRole(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('RoleController');
		$id = $args['roleId'];
		$op = $c->getRole($id);

		return json_encode($op);
	}

	public function getRoleTask(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('RoleController');
		$id = $args['roleId'];
		$op = $c->getRoleTask($id);

		return json_encode($op);
	}

	public function getActiveSession(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('SessionController');
		$userId = $_SESSION['tracker_userid'];
		$op = $c->getActiveSession($userId);

		return json_encode($op);
	}

	public function getSessionUser(Request $request, Response $response, array $args)
	{
		$id = $_SESSION['tracker_userid'];
		$user = $this->container->get('UserController');

		return json_encode($user->getUser($id));
	}

	public function postUpdateSessionActivity(Request $request, Response $response, array $args)
	{
		$id = $_SESSION['tracker_userid'];
		$session = $this->container->get('SessionController');
		$op = $session->updateUserSessionActivity($id);

		return json_encode($op);
	}

	public function getSessionCleanReorder(Request $request, Response $response, array $args)
	{
		$session = $this->container->get('SessionController');
		$op = $session->updateSessionCleanReorder();

		return json_encode($op);
	}

	public function getStatus(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('StatusController');
		$id = $args['statusId'];
		$op = $c->getStatus($id);

		return json_encode($op);
	}

	public function postUpdateStatus(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('StatusController');
		$post = $request->getParsedBody();
		$rawUserId = $post['user_id'];

		if (is_array($rawUserId)) {
			foreach ($rawUserId as $userId => $statusId) {
				$c->postUpdateStatus($this->filterString($userId), $this->filterString($statusId));
			}

			$op = array();
		} else {
			$userId = $this->filterString($rawUserId);
			$statusId = $this->filterString($post['status_id']);
			$op = $c->postUpdateStatus($userId, $statusId);
		}

		return json_encode($op);
	}

	public function getTask(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('TaskController');
		$id = $args['taskId'];
		$op = $c->getTask($id);

		return json_encode($op);
	}

	public function getOffice(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('OfficeController');
		$id = $args['officeId'];
		$op = $c->getOffice($id);

		return json_encode($op);
	}
	
	public function getDepartment(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('DepartmentController');
		$id = $args['departmentId'];
		$op = $c->getDepartment($id);

		return json_encode($op);
	}

	public function getDepartmentStatus(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('DepartmentController');
		$id = $args['departmentId'];
		$op = $c->getDepartmentStatus($id);

		return json_encode($op);
	}

	public function getCustomData(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('CustomDataController');
		$id = $args['typeId'];
		$op = $c->getCustomData($id);

		return json_encode($op);
	}

	public function postUpdateCustomDataValue(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('CustomDataController');
		$post = $request->getParsedBody();
		$typeId = $this->filterString($post['type_id']);
		$valueName = $this->filterString($post['value_name']);
		$valueVal = $this->filterString($post['value_val']);
		$valueDescr = $this->filterString($post['value_descr']);
		$op = $c->postUpdateCustomDataValue($typeId, $valueName, $valueVal, $valueDescr);

		return json_encode($op);
	}

	public function getReport(Request $request, Response $response, array $args)
	{
		$c = $this->container->get('ReportController');
		$post = $request->getParsedBody();
		$startDate = $this->filterString($post['start_date']);
		$endDate = $this->filterString($post['end_date']);
		$userId = $this->filterString($post['user_id']);
		$officeId = $this->filterString($post['office_id']);
		$reportType = $this->filterString($post['report_type']);

		if ('daily_summary' == $reportType) {
			$op = $c->getReportDaily($startDate, $endDate, $userId);
		} elseif ('detailed' == $reportType) {
			$op = $c->getReportDetailed($startDate, $endDate, $userId);
		} elseif ('range_summary' == $reportType) {
			$op = $c->getReportRange($startDate, $endDate, $userId);
		}

		return json_encode($op);
	}
}