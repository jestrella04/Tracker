<?php

/* --------- */
/* API calls */
/* --------- */

/* Config */
$app->post('/api/update/settings', 'ApiController:postUpdateConfig');

/* Users */
$app->get('/api/get/users/tasks/{userId}', 'ApiController:getUserTasks');
$app->get('/api/get/users/status/{userId}', 'ApiController:getUserStatus');
$app->get('/api/get/users/{userId}', 'ApiController:getUser');
$app->get('/api/get/users', 'ApiController:getUser');
$app->post('/api/insert/users', 'ApiController:postCreateUser');
//$app->post('/api/update/users/{userId}', '');
//$app->post('/api/update/users/{userId}/password', '');

/* Roles */
$app->get('/api/get/roles/{roleId}', 'ApiController:getRole');
$app->get('/api/get/roles/{roleId}/tasks', 'ApiController:getRoleTask');
$app->get('/api/get/roles', 'ApiController:getRole');
//$app->post('/api/insert/roles', '');
//$app->post('/api/delete/roles/{roleId}', '');

/* Session */
$app->get('/api/get/session', 'ApiController:getActiveSession');
$app->get('/api/get/session/user', 'ApiController:getSessionUser');
$app->post('/api/update/session/activity', 'ApiController:postUpdateSessionActivity');
$app->get('/api/update/session/clean', 'ApiController:getSessionCleanReorder')->setName('session-clean');

/* Status */
$app->get('/api/get/status/{statusId}', 'ApiController:getStatus');
$app->get('/api/get/status', 'ApiController:getStatus');
$app->post('/api/update/status', 'ApiController:postUpdateStatus');

/* Tasks */
$app->get('/api/get/tasks/{taskId}', 'ApiController:getTask');
$app->get('/api/get/tasks', 'ApiController:getTask');

/* Departments */
$app->get('/api/get/departments/{departmentId}', 'ApiController:getDepartment');
$app->get('/api/get/departments/{departmentId}/status', 'ApiController:getDepartmentStatus');
$app->get('/api/get/departments', 'ApiController:getDepartment');

/* Custom data */
$app->get('/api/get/custom-data/{typeId}', 'ApiController:getCustomData');
$app->post('/api/update/custom-data-type', 'ApiController:postUpdateCustomDataType');
$app->post('/api/update/custom-data-value', 'ApiController:postUpdateCustomDataValue');

/* Reports */
$app->post('/api/get/report', 'ApiController:getReport');
