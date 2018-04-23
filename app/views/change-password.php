<?php require __DIR__ . '/layouts/header.php'; ?>

<div class="container">
	<form id="password-update-form" class="form-signin" role="form" action="change-password" method="post" autocomplete="off">
		<fieldset disabled>
			<div class="logo text-center"><img src="assets/img/<?= $settings['company_logo']['value'] ?>"></div>
			<h2 class="form-signin-heading"><?= $settings['company_name']['value'] ?> Tracker</h2>
			<p class="lead text-center">You need to change your password</p>

			<div class="input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="dir-filter-clear">
						<i class="fas fa-key"></i>
					</span>
				</div>

				<input id="password1" type="password" class="form-control" name="password1" placeholder="Enter your current password" autocomplete="off" required autofocus>
			</div>
				
			<div class="input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="dir-filter-clear">
						<i class="fas fa-key"></i>
					</span>
				</div>

				<input id="password2" type="password" class="form-control" name="password2" placeholder="Enter a new password" autocomplete="off" required>
			</div>
			
			<div class="input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="dir-filter-clear">
						<i class="fas fa-key"></i>
					</span>
				</div>

				<input id="password3" type="password" class="form-control" name="password3" placeholder="Confirm new password" autocomplete="off" required>
			</div>

			<p class="form-text text-muted text-center">
				Your password must be at least 8 characters long, contain a capital letter,
				a lowercase letter, a number, and one of the following special characters
				<strong>!@#$%^&*</strong>
			</p>

			<input type="hidden" name="user_id" value="<?= $userId ?>">
			<input type="hidden" name="<?= $nameKey ?>" value="<?= $name ?>">
			<input type="hidden" name="<?= $valueKey ?>" value="<?= $value ?>">
			<button class="btn btn-lg btn-primary btn-block" type="submit">Change Password</button>
		</fieldset>
	</form>

	<div class="forgot-password text-center">
        <p class="lead">
            <a href="logout">Logout</a>
        </p>
    </div>
</div>

<?php require __DIR__ . '/layouts/flash-message.php'; ?>
<?php require __DIR__ . '/layouts/footer.php'; ?>
