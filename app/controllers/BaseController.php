<?php

namespace App\Controllers;

use Slim\Container;
use PHPMailer\PHPMailer\PHPMailer;

class BaseController
{
    protected $container;
    protected $renderer;
    protected $db;
    protected $csrf;
    protected $auth;

    public function __construct(Container $c)
    {
        $this->container = $c;

        $this->renderer = $this->container->get('renderer');
        $this->db = $this->container->get('db');
        $this->csrf = $this->container->get('csrf');
        $this->settings = $this->getAppSettings();
    }

    private function getAppSettings()
    {
        $sp = $this->db->query('CALL sp_select_config');
        $op = $sp->fetchAll();
        $settings = array();

        foreach ($op as $idx => $config) {
            $settings[$config['id']] = $config;
        }

        return $settings;
    }

    protected function filterString($string)
    {
        return filter_var($string, FILTER_SANITIZE_STRING);
    }

    protected function getCurrentUserId()
    {
        return $_SESSION['tracker_userid'];
    }

    protected function getFlashMessages()
    {
        if (isset($_SESSION['flash_message'])) {
            // Get message from the session
            $flash = $_SESSION['flash_message'];

            // Clear message so that it is not available in future loads
            $_SESSION['flash_message'] = array();

            // Reurn the capture session message
            if (is_array($flash) && !empty($flash)) {
                return $flash;
            }
        }
        

        return array();
    }

    protected function postFlashMessage($type, $message)
    {
        if (!isset($_SESSION['flash_message'][$type])) {
            $_SESSION['flash_message'][$type] = array();
        }

        array_push($_SESSION['flash_message'][$type], $message);
    }

    // Generates a strong password of N length containing at least one lower case letter,
    // one uppercase letter, one digit, and one special character. The remaining characters
    // in the password are chosen at random from those four sets.
    //
    // The available characters in each set are user friendly - there are no ambiguous
    // characters such as i, l, 1, o, 0, etc. This, coupled with the $add_dashes option,
    // makes it much easier for users to manually type or speak their passwords.
    //
    // Note: the $add_dashes option will increase the length of the password by
    // floor(sqrt(N)) characters.
    protected function generateStrongRandomPassword($length, $add_dashes = false, $available_sets = 'luds')
    {
        $sets = array();

        if (strpos($available_sets, 'l') !== false) $sets[] = 'abcdefghjkmnpqrstuvwxyz';
        if (strpos($available_sets, 'u') !== false) $sets[] = 'ABCDEFGHJKMNPQRSTUVWXYZ';
        if (strpos($available_sets, 'd') !== false) $sets[] = '23456789';
        if (strpos($available_sets, 's') !== false) $sets[] = '!@#$%&*?';

        $all = '';
        $password = '';

        foreach ($sets as $set) {
            $password .= $set[array_rand(str_split($set))];
            $all .= $set;
        }

        $all = str_split($all);

        for ($i = 0; $i < $length - count($sets); $i++) $password .= $all[array_rand($all)];

        $password = str_shuffle($password);

        if (!$add_dashes) return $password;

        $dash_len = floor(sqrt($length));
        $dash_str = '';

        while (strlen($password) > $dash_len) {
            $dash_str .= substr($password, 0, $dash_len) . '-';
            $password = substr($password, $dash_len);
        }

        $dash_str .= $password;

        return $dash_str;
    }

    protected function sendMail($toName, $toEmail, $subject, $message)
    {
        $mail = new PHPMailer();                              // Passing `true` enables exceptions

        try {
            //Server settings
            $mail->isSMTP();                                      // Set mailer to use SMTP
            $mail->Host = 'smtp1.example.com;smtp2.example.com';  // Specify main and backup SMTP servers
            $mail->SMTPAuth = true;                               // Enable SMTP authentication
            $mail->Username = 'user@example.com';                 // SMTP username
            $mail->Password = 'secret';                           // SMTP password
            $mail->SMTPSecure = 'tls';                            // Enable TLS encryption, `ssl` also accepted
            $mail->Port = 587;                                    // TCP port to connect to

            //Recipients
            $mail->setFrom('from@example.com', 'Mailer');
            $mail->addAddress($toEmail, $toName);     // Add a recipient

            //Content
            $mail->isHTML(true);                                  // Set email format to HTML
            $mail->Subject = $subject;
            $mail->Body = $message;
            //$mail->AltBody = '';

            $mail->send();
        } catch (Exception $e) {
            //echo 'Message could not be sent. Mailer Error: ', $mail->ErrorInfo;
        }
    }
}