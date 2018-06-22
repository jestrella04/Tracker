<?php

namespace App\Controllers;

class ReportController extends BaseController
{
	public function getReport($reportType, $startDate, $endDate, $userId = '', $officeId = '')
	{
		if ('daily_summary' == $reportType) $proc = 'sp_select_activity_daily';
		else if ('detailed' == $reportType) $proc = 'sp_select_activity_detailed';
		else if ('range_summary' == $reportType) $proc = 'sp_select_activity_range';

		if (!empty($userId)) {
			$sp = $this->db->prepare('CALL '. $proc .'(?, ?, ?, NULL)');
			$sp->execute(array($startDate, $endDate, $userId));
		} else if (!empty($officeId) && empty($userId)) {
			$sp = $this->db->prepare('CALL '. $proc .'(?, ?, NULL, ?)');
			$sp->execute(array($startDate, $endDate, $officeId));
		} else {
			$sp = $this->db->prepare('CALL '. $proc .'(?, ?, NULL, NULL)');
			$sp->execute(array($startDate, $endDate));
		}

		$op = $sp->fetchAll();

		return $op;
	}
}