<?php

namespace App\Controllers;

class ConfigController extends BaseController
{
	public function updateConfig($id, $val)
	{
		$sp = $this->db->prepare('CALL sp_update_config(?, ?)');
		$sp->execute(array($id, $val));
	}
}