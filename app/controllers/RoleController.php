<?php

namespace App\Controllers;

class RoleController extends BaseController
{
    public function getRole($id = '')
    {
        if (!empty($id)) {
            $sp = $this->db->prepare('CALL sp_select_role(?)');
            $sp->execute(array($id));
            $op = $sp->fetch();
        } else {
            $sp = $this->db->query('CALL sp_select_role(NULL)');
            $op = $sp->fetchAll();
        }

        return $op;
    }

    public function getRoleTask($id)
    {
        $sp = $this->db->prepare('CALL sp_select_role_allowed_task(?)');
        $sp->execute(array($id));
        $op = $sp->fetchAll();

        return $op;
    }
}
