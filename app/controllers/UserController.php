<?php

namespace App\Controllers;

class UserController extends BaseController
{
    public function getUser($id = '')
    {
        if (!empty($id)) {
            $sp = $this->db->prepare('CALL sp_select_user(?)');
            $sp->execute(array($id));
            $op = $sp->fetch();
        } else {
            $sp = $this->db->query('CALL sp_select_user(NULL)');
            $op = $sp->fetchAll();
        }

        return $op;
    }

    public function getUserByEmail($email)
    {
        $sp = $this->db->prepare('CALL sp_select_user_by_email(?)');
        $sp->execute(array($email));
        $op = $sp->fetch();

        return $op;
    }

    public function getUserPasswordHash($id)
    {
        $sp = $this->db->prepare('CALL sp_select_user_password_hash(?)');
        $sp->execute(array($id));
        $op = $sp->fetchColumn();

        return $op;
    }

    public function getUserAllowedStatus($id)
    {
        $user = $this->container->get('UserController')->getUser($id);
        $dept = $this->container->get('DepartmentController');
        $userAllowedStatus = $dept->getDepartmentStatus($user['id_department']);

        return $userAllowedStatus;
    }

    public function getUserAllowedTasks($id)
    {
        $user = $this->container->get('UserController')->getUser($id);
        $role = $this->container->get('RoleController');
        $userAllowedTasks = $role->getRoleTask($user['id_role']);

        return $userAllowedTasks;
    }

    public function postCreateUser($id, $name, $email, $password, $roleId, $departmentId)
    {
        if (!empty($id) && !empty($name) && !empty($email) && !empty($password) && !empty($roleId) && !empty($departmentId)) {
            $passwordHash = password_hash($password, PASSWORD_DEFAULT);
            $sp = $this->db->prepare('CALL sp_insert_user(?,?,?,?,?,?,@insertedId)');
            $sp->execute(array($id, $roleId, $departmentId, $name, $email, $passwordHash));
            $sp->closeCursor();
            $op = $this->db->query('SELECT @insertedId AS id')->fetch();

            if ($op) {
                $template = 'user-created.html';
    
                $replace = array(
                    '{{USER_NAME}}' => $name,
                    '{{COMPANY_NAME}}' => $this->settings['company_name']['value'],
                    '{{NEW_PASSWORD}}' => $password,
                    '{{NEW_USERID}}' => $id,
                    '{{CURRENT_YEAR}}' => date('Y')
                );
                
                $toName = $name;
                $toEmail = $email;
                $subject = 'Tracker - Welcome to ' . $this->settings['company_name']['value'];
                $message = prepareEmailTemplate($template, $replace);
    
                $this->sendMail($toName, $toEmail, $subject, $message);

                return $op;
            }
        }

        return false;
    }

    public function postUserPasswordUpdate($id, $passwordHash, $isDefault = 0)
    {
        $sp = $this->db->prepare('CALL sp_update_user_password(?,?,?)');
        $op = $sp->execute(array($id, $passwordHash, $isDefault));

        return $op;
    }

    public function postResetPassword($id)
    {
        $randomPassword = $this->generateStrongRandomPassword(10);
        $randomPasswordHash = password_hash($randomPassword, PASSWORD_DEFAULT);
        $user = $this->getUser($id);
        $reset = $this->postUserPasswordUpdate($id, $randomPasswordHash, 1);

        if ($reset) {
            $template = 'password-reset.html';

            $replace = array(
                '{{USER_NAME}}' => $user['name'],
                '{{COMPANY_NAME}}' => $this->settings['company_name']['value'],
                '{{NEW_PASSWORD}}' => $randomPassword,
                '{{CURRENT_YEAR}}' => date('Y')
            );
            
            $toName = $user['name'];
            $toEmail = $user['email'];
            $subject = 'Tracker - Password Reset';
            $message = prepareEmailTemplate($template, $replace);

            if ($this->sendMail($toName, $toEmail, $subject, $message)) {
                return true;
            }
        }

        return false;
    }
}