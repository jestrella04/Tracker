<?php

/* --------- */
/* API calls */
/* --------- */

$app->group('/api', function () {
    /* Config */
    $this->post('/update/settings', 'ApiController:postUpdateConfig');

    /* Users */
    $this->get('/get/users/tasks/{userId}', 'ApiController:getUserTasks');
    $this->get('/get/users/status/{userId}', 'ApiController:getUserStatus');
    $this->get('/get/users/{userId}', 'ApiController:getUser');
    $this->get('/get/users', 'ApiController:getUser');
    $this->post('/insert/users', 'ApiController:postCreateUser');
    //$this->post('/update/users/{userId}', '');
    //$this->post('/update/users/{userId}/password', '');

    /* Roles */
    $this->get('/get/roles/{roleId}', 'ApiController:getRole');
    $this->get('/get/roles/{roleId}/tasks', 'ApiController:getRoleTask');
    $this->get('/get/roles', 'ApiController:getRole');
    //$this->post('/insert/roles', '');
    //$this->post('/delete/roles/{roleId}', '');

    /* Session */
    $this->get('/get/session', 'ApiController:getActiveSession');
    $this->get('/get/session/user', 'ApiController:getSessionUser');
    $this->post('/update/session/activity', 'ApiController:postUpdateSessionActivity');
    $this->get('/update/session/clean', 'ApiController:getSessionCleanReorder')->setName('session-clean');

    /* Status */
    $this->get('/get/status/{statusId}', 'ApiController:getStatus');
    $this->get('/get/status', 'ApiController:getStatus');
    $this->post('/update/status', 'ApiController:postUpdateStatus');

    /* Tasks */
    $this->get('/get/tasks/{taskId}', 'ApiController:getTask');
    $this->get('/get/tasks', 'ApiController:getTask');

    /* Departments */
    $this->get('/get/departments/{departmentId}', 'ApiController:getDepartment');
    $this->get('/get/departments/{departmentId}/status', 'ApiController:getDepartmentStatus');
    $this->get('/get/departments', 'ApiController:getDepartment');

    /* Offices */
    $this->get('/get/offices/{officeId}', 'ApiController:getOffice');
    $this->get('/get/offices', 'ApiController:getOffice');

    /* Custom data */
    $this->get('/get/custom-data/{typeId}', 'ApiController:getCustomData');
    $this->post('/update/custom-data-type', 'ApiController:postUpdateCustomDataType');
    $this->post('/update/custom-data-value', 'ApiController:postUpdateCustomDataValue');

    /* Reports */
    $this->post('/get/report', 'ApiController:getReport');
});
