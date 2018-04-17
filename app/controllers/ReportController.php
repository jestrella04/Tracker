<?php

namespace App\Controllers;

class ReportController extends BaseController
{
    public function getReportDaily($startDate, $endDate, $id = '')
    {
        if (!empty($id)) {
            $sp = $this->db->prepare('CALL sp_select_activity_daily(?, ?, ?)');
            $sp->execute(array($startDate, $endDate, $id));
        } else {
            $sp = $this->db->prepare('CALL sp_select_activity_daily(?, ?, NULL)');
            $sp->execute(array($startDate, $endDate));
        }

        $op = $sp->fetchAll();

        return $op;
    }

    public function getReportDetailed($startDate, $endDate, $id = '')
    {
        if (!empty($id)) {
            $sp = $this->db->prepare('CALL sp_select_activity_detailed(?, ?, ?)');
            $sp->execute(array($startDate, $endDate, $id));
        } else {
            $sp = $this->db->prepare('CALL sp_select_activity_detailed(?, ?, NULL)');
            $sp->execute(array($startDate, $endDate));
        }

        $op = $sp->fetchAll();

        return $op;
    }

    public function getReportRange($startDate, $endDate, $id = '')
    {
        if (!empty($id)) {
            $sp = $this->db->prepare('CALL sp_select_activity_range(?, ?, ?)');
            $sp->execute(array($startDate, $endDate, $id));
        } else {
            $sp = $this->db->prepare('CALL sp_select_activity_range(?, ?, NULL)');
            $sp->execute(array($startDate, $endDate));
        }

        $op = $sp->fetchAll();

        return $op;
    }
}