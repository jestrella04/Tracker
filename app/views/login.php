<?php require __DIR__ . '/layouts/header.php'; ?>

        <form class="form-signin" role="form" action="login" method="post" autocomplete="off">
            <div class="logo text-center"><img src="public/assets/img/<?= $settings['company_logo']['value'] ?>"></div>
            <h2 class="form-signin-heading"><?= $settings['company_name']['value'] ?> Tracker</h2>
            <p class="lead text-center">Please sign in</p>

            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="dir-filter-clear">
                        <i class="fas fa-user"></i>
                    </span>
                </div>
                
                <input type="text" class="form-control" name="userid" placeholder="Enter your username" autocomplete="off" required autofocus>
            </div>

            <div class="input-group input-group-lg">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="dir-filter-clear">
                        <i class="fas fa-key"></i>
                    </span>
                </div>

                <input type="password" class="form-control" name="password" placeholder="Enter your password" autocomplete="off" required>
            </div>
            
            <input type="hidden" name="<?= $nameKey ?>" value="<?= $name ?>">
            <input type="hidden" name="<?= $valueKey ?>" value="<?= $value ?>">

            <button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
        </form>

        <div class="forgot-password text-center">
            <p class="lead">
                <a href="forgot-password">Forgot password?</a>
            </p>
        </div>

<?php require __DIR__ . '/layouts/flash-message.php'; ?>
<?php require __DIR__ . '/layouts/footer.php'; ?>