<?php if ($auth->isUserAllowedTask('Configuration')) : ?>
<!-- Configuration modal window -->
<div id="admin-settings-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="AdminUsersModal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		  	<div class="modal-header">
				<h4 class="modal-title">Application Settings</h4>

				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			  		<i class="fas fa-times"></i>
				</button>
		  	</div>

			<div id="admin-settings-panel" class="modal-body">
				<form id="admin-settings-form" role="form">
				<?php foreach ($settings as $config) : ?>
                    <div class="form-group row">
						<label for="<?= $config['id'] ?>" class="col-sm-4 col-form-label"><?= $config['name'] ?></label>
						
                        <div class="col-sm-8">
                            <input type="<?= $config['type'] ?>" class="form-control" id="<?= $config['id'] ?>" name="<?= $config['id'] ?>" value="<?= $config['value'] ?>">

                            <small class="form-text text-muted"><?= $config['description'] ?></small>
                        </div>
                    </div>    
                <?php endforeach ?>
				</form>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary" form="admin-settings-form">Save changes</button>
			</div>
		</div>
	</div>
</div>
<?php endif; ?>
