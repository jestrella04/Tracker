<?php

namespace App\Controllers;

class SessionController extends BaseController
{
    public function getActiveSession()
    {
        $sp = $this->db->query('CALL sp_select_session()');
        $op = $sp->fetchAll();

        return $op;
    }

    public function updateSessionCleanReorder()
    {
        $sp = $this->db->prepare('CALL `sp_update_session_clean_reorder`();');
        $sp->execute();
    }

    public function addActiveSession($id)
    {
        $sp = $this->db->prepare('CALL `sp_insert_session`(?);');
        $sp->execute(array($id));
        
        $this->updateSessionCleanReorder();
    }

    public function updateUserSessionActivity($id)
    {
        $sp = $this->db->prepare('CALL `sp_update_user_session_activity`(?);');
        $sp->execute(array($id));
    }

    public function removeActiveSession($id)
    {
        $sp = $this->db->prepare('CALL `sp_delete_session`(?);');
        $sp->execute(array($id));

        $this->updateSessionCleanReorder();
    }

    public function updateActiveSessionStatus($id, $status)
    {
        $sp = $this->db->prepare('CALL `sp_update_session_user_status_change`(?);');
        $sp->execute(array($id, $status));

        $this->updateSessionCleanReorder();
    }
}