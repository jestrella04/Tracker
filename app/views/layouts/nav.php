<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="public/assets/img/logo-nav.png" width="30" height="30" class="d-inline-block align-top" alt="">
            <?= $settings['company_name']['value'] ?>
        </a>
        
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#tracker-navbar-collapse" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="tracker-navbar-collapse">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#change-status-modal">
                        <i class="fas fa-clipboard-check"></i> Change Status
                    </a>
                </li>

                <?php if ($auth->isUserAllowedTask('GTA')) : ?>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#gta-modal">
                        <i class="fas fa-bullhorn"></i> GoToAssist
                    </a>
                </li>
                <?php endif; ?>

                <?php if ($auth->isUserAllowedTask('Directory')) : ?>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#dir-modal">
                        <i class="fas fa-address-book"></i> Directory
                    </a>
                </li>
                <?php endif; ?>

                <?php if (!$auth->isUserAllowedTask('Reports')) : ?>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#admin-reports-modal">
                        <i class="fas fa-file"></i> Reports
                    </a>
                </li>
                <?php endif; ?>

                <?php if ($auth->isUserAllowedTask('Configuration') || $auth->isUserAllowedTask('Reports') || $auth->isUserAllowedTask('Manage Users') || $auth->isUserAllowedTask('Change User Status')) : ?>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-user-secret"></i>Administrator
                    </a>

                    <div class="dropdown-menu" aria-labelledby="dropdown01">
                        <?php if ($auth->isUserAllowedTask('Configuration')) : ?>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#admin-settings-modal">Configuration</a>
                        <?php endif; ?>

                        <?php if ($auth->isUserAllowedTask('Reports')) : ?>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#admin-reports-modal">Reporting Tools</a>
                        <?php endif; ?>

                        <?php if ($auth->isUserAllowedTask('Manage Users')) : ?>
                        <a class="dropdown-item disabled" href="#" data-toggle="modal" data-target="#admin-users-modal">Users Manager</a>
                        <?php endif; ?>

                        <?php if ($auth->isUserAllowedTask('Change User Status')) : ?>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#admin-session-modal">Session Manager</a>
                        <?php endif; ?>
                    </div>
                </li>
                <?php endif; ?>
            </ul>

            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="btn btn-outline-danger" href="logout">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>