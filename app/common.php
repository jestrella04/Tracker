<?php

function errorType2Text($type)
{
    if ('danger' === $type) return 'Oops... Something went wrong!';
    if ('success' === $type) return 'Whoray... Everything looks good!';
}