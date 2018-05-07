<?php

namespace App\Controllers;

class DepartmentController extends BaseController
{
    public function getDepartment($id = '')
    {
        if (!empty($id)) {
            $sp = $this->db->prepare('CALL sp_select_department(?)');
            $sp->execute(array($id));
            $op = $sp->fetch();
        } else {
            $sp = $this->db->query('CALL sp_select_department(NULL)');
            $op = $sp->fetchAll();
        }

        return $op;
    }

    public function getDepartmentStatus($id)
    {
        $sp = $this->db->prepare('CALL sp_select_department_allowed_status(?)');
        $sp->execute(array($id));
        $op = $sp->fetchAll();

        return $op;
    }
}