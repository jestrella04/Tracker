<?php

$users = getActiveAgents();
$usersCount = count( $users );

?>
	<div id="admin-users">
		<form id="admin-form" class="form-horizontal" role="form">
			<fieldset>
				<legend>You can now manage users</legend>

				<?php for ( $i = 0; $i < $usersCount; $i++ ) :
					$statuses = getStatuses( $users[$i]['userid'] );
					$statusesCount = count( $statuses );
				?>
				<div class="form-group">
					<label for="" class="col-sm-4 control-label"><?php echo $users[$i]['username'] ?></label>
					<div class="col-sm-8">
						<select name="agents[<?php echo $users[$i]['userid'] ?>]" class="form-control">
						<?php for ( $j = 0; $j < $statusesCount; $j++ ) : ?>
							<option value="<?php echo $statuses[$j]['statusid'] ?>" <?php if ( $statuses[$j]['statusid'] == $users[$i]['statusid'] ) echo 'selected="selected"' ?>><?php echo $statuses[$j]['statusname'] ?></option>
						<?php endfor ?>
						</select>
					</div>
				</div>
				<?php endfor ?>

				<input type="hidden" name="src" value="admin">
			</fieldset>
		</form>
	</div>
