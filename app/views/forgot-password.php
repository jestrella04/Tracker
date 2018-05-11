<?php require __DIR__ . '/layouts/header.php'; ?>

<div class="container">
	<form id="password-update-form" class="form-signin" role="form" action="forgot-password" method="post" autocomplete="off">
        <fieldset disabled>
            <div class="logo text-center"><img src="static/img/<?= $settings['company_logo']['value'] ?>"></div>
            <h2 class="form-signin-heading"><?= $settings['company_name']['value'] ?> Tracker</h2>
            <p class="lead text-center">Password Recovery</p>
            
            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="dir-filter-clear">
                        <i class="fas fa-at fa-fw"></i>
                    </span>
                </div>

                <input type="email" class="form-control" name="recovery_email" placeholder="Enter your email address" autocomplete="off" required autofocus>
            </div>

            <input type="hidden" name="<?= $nameKey ?>" value="<?= $name ?>">
            <input type="hidden" name="<?= $valueKey ?>" value="<?= $value ?>">
            <button class="btn btn-lg btn-primary btn-block" type="submit">Recover Password</button>
        <fieldset>
    </form>
    
    <div class="forgot-password text-center">
        <p class="lead">
            <a href="login">Back to the login page</a>
        </p>
    </div>
</div>

<?php require __DIR__ . '/layouts/flash-message.php'; ?>
<?php require __DIR__ . '/layouts/footer.php'; ?>