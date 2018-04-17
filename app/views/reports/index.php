<?php

$userid = isset( $_GET['report-userid'] ) ? strtolower( $_GET['report-userid'] ) : null;
$type = isset( $_GET['report-type'] ) ? strtolower( $_GET['report-type'] ) : null;
$start = isset( $_GET['report-start'] ) ? strtolower( $_GET['report-start'] ) : null;
$end = isset( $_GET['report-end'] ) ? strtolower( $_GET['report-end'] ) : null;

if ( 'all' == $userid )
{
	$appendText = 'for all users';
}

else
{
	$appendText = 'for user ' . $userid;
}

if ( is_null( $userid ) || is_null( $type ) || is_null( $start ) || is_null( $end ) ):
?>
	<div class="container">
		<div class="alert alert-danger text-center" role="alert"><strong>There was an error generating the report.</strong></div>
	</div>
<?php
	else :
		$data = getReport( $userid, $type, $start, $end );
?>
  <div class="container" id="tracker-reports">
		<div>
			<div class="pull-left">
				<h4>Tracker Reports - Cenpos DR<br>
					<small>From <?php echo $start; ?> to <?php echo $end; ?></small><br>
					<small>Displaying <?php echo count( $data ); ?> records <?php echo $appendText; ?>.</small>
				</h4>
			</div>

			<div class="btn-print pull-right">
				<button type="button" class="btn btn-default btn-xs" id="reports-excel-button"><i class="fas fa-list" title="Export to Excel"></i></button>
				<button type="button" class="btn btn-default btn-xs" id="reports-print-button"><i class="fas fa-print" title="Print"></i></button>
			</div>
		</div>

		<div style="clear:both;"></div>

		<?php
		if ( $data )
		{
			printReportTable( $data );
		}

		else
		{
			echo '<div class="alert alert-info text-center" role="alert"><strong>No information to show at the moment.</strong></div>';
		}
		?>
  </div> <!-- /container -->
<?php endif ?>
