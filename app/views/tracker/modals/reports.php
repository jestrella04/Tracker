<!-- Reporting tools modal window -->
<div id="admin-reports-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="AdminStatsModal" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
			<h4 class="modal-title">Reporting Tools</h4>

			<div class="btn-group btn-group-sm float-right">
				<button type="button" class="btn btn-default" id="reports-excel-button" disabled><i class="fas fa-file-excel" title="Export to Excel"></i></button>
				<button type="button" class="btn btn-default" id="reports-print-button" disabled><i class="fas fa-print" title="Print"></i></button>
				<button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close"><i class="fas fa-times"></i></button>
			</div>
		  </div>

			<div id="admin-stats-panel" class="modal-body">
				<div id="admin-reports-searchbox">
					<form id="admin-reports-form" role="form">
						<fieldset>
							<div class="form-row">
								<div class="col">
									<div class="form-group">
										<label for="report-userid">User:</label>
										<select class="form-control form-control-sm" id="report-userid" name="user_id"></select>
									</div>
								</div>

								<div class="col">
									<div class="form-group">
										<label for="report-type">Report Type:</label>
										<select class="form-control form-control-sm" id="report-type" name="report_type" required>
											<option value="daily_summary">Daily Summary</option>
											<option value="range_summary">Range Summary</option>
											<option value="detailed">Detailed</option>
										</select>
									</div>
								</div>
								
								<div class="col">
									<div class="form-group">
										<label for="report-start">Begin Date:</label>
										<input type="date" class="form-control form-control-sm" id="report-start" name="start_date" max="<?= $currDate; ?>" placeholder="yyyy-mm-dd" required>
									</div>
								</div>

								<div class="col">
									<div class="form-group">
										<label for="report-end">End Date:</label>
										<input type="date" class="form-control form-control-sm" id="report-end" name="end_date" max="<?= $currDate; ?>" placeholder="yyyy-mm-dd" required>
									</div>
								</div>

								<div class="col-2">
									<div class="form-group">
										<label for="">&nbsp;</label>
										<button type="submit" class="form-control btn btn-primary btn-sm">Get Report</button>
									</div>
								</div>
							</div>
						</fieldset>
					</form>
				</div>

				<div id="admin-reports-empty" class="table table-bordered">
					<p>There is no data to display</p>
				</div>

				<div id="admin-reports-loading" class="table table-bordered d-none">
					<div class="loading-animation fa-3x">
						<i class="fas fa-spinner fa-spin"></i>
					</div>
				</div>

				<div id="admin-reports-container" class="d-none">
					<table id="admin-reports-table" class="table table-bordered table-hover table-sm"></table>
				</div>
			</div>
		</div>
	</div>
</div>
