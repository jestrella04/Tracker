<?php

namespace App\Controllers;

class OfficeController extends BaseController
{
	public function getOffice($id = '')
	{
		if (!empty($id)) {
			$sp = $this->db->prepare('CALL sp_select_office(?)');
			$sp->execute(array($id));
			$op = $sp->fetch();
		} else {
			$sp = $this->db->query('CALL sp_select_office(NULL)');
			$op = $sp->fetchAll();
		}

		return $op;
	}
}
