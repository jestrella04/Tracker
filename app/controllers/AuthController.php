<?php

namespace App\Controllers;

class AuthController extends BaseController
{
	private $userId;
	private $userPassword;
	private $userPasswordHash;

	public function setUserId($id)
	{
		$this->userId = $id;
	}

	public function setUserPassword($password)
	{
		$this->userPassword = $password;
	}

	public function isValidUser()
	{
		$validUserId = $this->container->get('UserController')->getUser($this->userId);

		if (!empty($validUserId)) {
			if ($validUserId['enabled'] > 0) {
				$this->userPasswordHash = $this->container->get('UserController')->getUserPasswordHash($this->userId);
				return true;
			}
		}

		return false;
	}

	public function isValidPassword()
	{
		if (password_verify($this->userPassword, $this->userPasswordHash)) {
			return true;
		}

		return false;
	}

	public function isDefaultPassword()
	{
		$validUserId = $this->container->get('UserController')->getUser($_SESSION['tracker_userid']);

		if ($validUserId) {
			if ($validUserId['password_is_default'] > 0) {
				return true;
			}
		}

		return false;
	}

	public function isValidSession()
	{
		if (isset($_SESSION['tracker_userid'])) {
			$sessionTimeout = 15 * 60;
			$sessionDateUpdate = isset($_SESSION['tracker_date_updated']) ? $_SESSION['tracker_date_updated'] : 0;
			$sessionDateCurrent = time();

			if (($sessionDateCurrent - $sessionDateUpdate) < $sessionTimeout) {
				return true;
			}
		}

		return false;
	}

	public function isUserAllowedTask($task)
	{
		$user = $this->container->get('UserController');
		$userAllowedTasks = $user->getUserAllowedTasks($this->userId);

		foreach ($userAllowedTasks as $id => $name) {
			if (array_search($task, $name, $strict = true)) {
				return true;
			}
		}

		return false;
	}

	public function isUserAllowedStatus($status)
	{
		$user = $this->container->get('UserController');
		$userAllowedStatus = $user->getUserAllowedStatus($this->userId);

		foreach ($userAllowedStatus as $id => $name) {
			if (array_search($status, $name, $strict = true)) {
				return true;
			}
		}

		return false;
	}

	public function updateSessionActivity()
	{
		if (isset($_SESSION['tracker_userid'])) {
			$_SESSION['tracker_date_updated'] = time();
		}
	}
}