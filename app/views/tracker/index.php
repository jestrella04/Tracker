<?php

/* Nav panel */
include ROOT_PATH . '/app/views/layouts/nav.php';

/* Main screen */
include ROOT_PATH . '/app/views/tracker/users.php';

/* User modals */
include ROOT_PATH . '/app/views/tracker/modals/status.php';
include ROOT_PATH . '/app/views/tracker/modals/gta.php';
include ROOT_PATH . '/app/views/tracker/modals/directory.php';
include ROOT_PATH . '/app/views/tracker/modals/reports.php';

/* Admin modals */
include ROOT_PATH . '/app/views/tracker/modals/admin/manage-sessions.php';
include ROOT_PATH . '/app/views/tracker/modals/admin/manage-users.php';
include ROOT_PATH . '/app/views/tracker/modals/admin/manage-settings.php';
