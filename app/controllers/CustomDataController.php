<?php

namespace App\Controllers;

class CustomDataController extends BaseController
{
	public function getCustomData($typeId)
	{
		$sp = $this->db->prepare('CALL sp_select_custom_data_value(?)');
		$sp->execute(array($typeId));
		$op = $sp->fetchAll();

		return $op;
	}

	public function postUpdateCustomDataValue($typeId, $valueName, $valueVal, $valueDescr)
	{
		if (!empty($valueVal) && empty($valueName)) {
			$sp = $this->db->prepare('CALL sp_update_custom_data_value_clear(?,?)');
			$sp->execute(array($typeId, $valueVal));
			$op = array('info' => 'Session updated successfully.');
		} elseif (!empty($typeId) && !empty($valueName) && !empty($valueVal)) {
			$sp = $this->db->prepare('CALL sp_update_custom_data_value(?,?,?,?)');
			$sp->execute(array($typeId, $valueName, $valueVal, $valueDescr));
			$op = array('info' => 'Session updated successfully.');
		} else {
			$op = array('error' => 'Please provide a valid identifier.');
		}

		return $op;
	}
}