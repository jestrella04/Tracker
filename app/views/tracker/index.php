<?php

/* Nav panel */
include __DIR__ . '/../layouts/nav.php';

/* Main screen */
include __DIR__ . '/users.php';

/* User modals */
include __DIR__ . '/modals/status.php';
include __DIR__ . '/modals/gta.php';
include __DIR__ . '/modals/directory.php';
include __DIR__ . '/modals/reports.php';

/* Admin modals */
include __DIR__ . '/modals/admin/manage-sessions.php';
include __DIR__ . '/modals/admin/manage-users.php';
include __DIR__ . '/modals/admin/manage-settings.php';
