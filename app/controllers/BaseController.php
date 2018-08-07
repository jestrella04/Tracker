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
		$this->flash = $this->container->get('flash');
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
		$mail = new PHPMailer();
		$mailMethod = null !== getenv('MAIL_METHOD') ? getenv('MAIL_METHOD') : 'Mail';

		if ('smtp' == strtolower($mailMethod)) {
			// SMTP Server settings
			//$mail->SMTPDebug = 2;
			$mail->isSMTP();
			$mail->Host = getenv('SMTP_HOST');
			$mail->SMTPAuth = true;
			$mail->Username = getenv('SMTP_USER');
			$mail->Password = getenv('SMTP_PASS');
			$mail->SMTPSecure = 'tls';
			$mail->Port = getenv('SMTP_PORT');
		} else if ('mail' == strtolower($mailMethod)) {
			$mail->isMail();
		}

        // Recipients
		$mail->setFrom($this->settings['company_email']['value'], 'Tracker');
		$mail->addAddress($toEmail, $toName);

        // Content
		$mail->isHTML(true);
		$mail->Subject = $subject;
		$mail->Body = $message;
        //$mail->AltBody = '';

        // Send the message, check for errors
		if (!$mail->send()) {
			$this->container->get('logger')->info('Message could not be sent. Mailer Error: ' . $mail->ErrorInfo);
			return false;
		} else {
			return true;
		}
	}
}