<?php

namespace App\Controllers;

class TaskController extends BaseController
{
    public function getTask($id = '')
    {
        if (!empty($id)) {
            $sp = $this->db->prepare('CALL sp_select_task(?)');
            $sp->execute(array($id));
            $op = $sp->fetch();
        } else {
            $sp = $this->db->query('CALL sp_select_task(NULL)');
            $op = $sp->fetchAll();
        }

        return $op;
    }
}