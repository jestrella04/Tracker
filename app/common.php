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