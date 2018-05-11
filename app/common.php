<?php

function errorType2Text($type)
{
	if ('danger' === $type) return 'Oops... Something went wrong!';
	if ('success' === $type) return 'Whoray... Everything looks good!';
}

function validatePassword($password)
{
	return preg_match('/^(?=.*[\d])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*])[\w!@#$%^&*]{8,}$/', $password);
}

function prepareEmailTemplate($template, $arrayReplace = array())
{
	$templateRealPath = ROOT_PATH . '/app/views/mailer/' . $template;

	if (file_exists($templateRealPath) && is_array($arrayReplace)) {
		$templateHtmlContents = file_get_contents($templateRealPath);

		foreach ($arrayReplace as $search => $replace) {
			$templateHtmlContents = str_replace($search, $replace, $templateHtmlContents);
		}

		return $templateHtmlContents;
	} else {
		return false;
	}
}

function safeRedirect($url)
{
	$dest = '';
	$dir = dirname($_SERVER['SCRIPT_NAME']);

	if (!empty($dir) && '/' !== $dir) {
		$dest = $dir . '/';
	}

	$dest = $dest . $url;
	$dest = str_replace('//', '/', $dest);

	return $dest;
}