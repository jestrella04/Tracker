<?php

namespace App\Controllers;

class StatusController extends BaseController
{
	public function getStatus($id = '')
	{
		if (!empty($id)) {
			$sp = $this->db->prepare('CALL sp_select_status(?)');
			$sp->execute(array($id));
			$op = $sp->fetch();
		} else {
			$sp = $this->db->query('CALL sp_select_status(NULL)');
			$op = $sp->fetchAll();
		}

		return $op;
	}

	public function postUpdateStatus($id, $statusId)
	{
		if (0 == $statusId) {
			$sp = $this->db->prepare('CALL sp_delete_session(?)');
			$sp->execute(array($id));
			$op = array('info' => 'Session updated successfully.');
		} else if (!empty($id) && !empty($statusId)) {
			$sp = $this->db->prepare('CALL sp_update_session_user_status_change(?,?)');
			$sp->execute(array($id, $statusId));
			$op = array('info' => 'Session updated successfully.');
		} else {
			$op = array('error' => 'Please provide a valid identifier.');
		}

		return $op;
	}
}