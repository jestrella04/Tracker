<?php if ($auth->isUserAllowedTask('Directory')) : ?>
	<!-- Directory modal window -->
    <div id="dir-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="DirectoryModal" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Phone Directory</h4>

					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<i class="fas fa-times"></i>
					</button>
				</div>

				<div class="modal-body">
					<ul class="nav nav-tabs" role="tablist">
						<li class="nav-item"><a class="nav-link active" href="#internal-extensions" aria-controls="internal-extensions" role="tab" data-toggle="tab">Local</a></li>
						<li class="nav-item"><a class="nav-link" href="#miami-extensions" aria-controls="miami-extensions" role="tab" data-toggle="tab">Miami</a></li>
						<li class="nav-item"><a class="nav-link" href="#external-numbers" aria-controls="external-numbers" role="tab" data-toggle="tab">External</a></li>
					</ul>

					<div id="dir-filter-container" class="row justify-content-md-center">
						<div class="col col-md-6">
							<div class="input-group">
								<input type="text" id="dir-filter-input" class="form-control" placeholder="Filter directory by...">

								<div class="input-group-append">
									<span class="input-group-text" id="dir-filter-clear" title="Clear applied filter">
										<i class="fas fa-minus-circle"></i>
									</span>
								</div>
							</div>
						</div>
					</div>

					<div class="tab-content">
						<!-- Internal Extensions -->
						<div role="tabpanel" class="tab-pane fade show active" id="internal-extensions">
							<table id="directory-dom-table" class="table table-hover table-bordered dir-table-filter">
								<thead>
									<tr>
										<th>Name</th>
										<th>Extension</th>
									</tr>
								</thead>
								
								<tbody id="directory-dom"></tbody>
							</table>
						</div>

						<!-- Miami Extensions -->
						<div role="tabpanel" class="tab-pane fade" id="miami-extensions">
							<table id="directory-mia-table" class="table table-hover table-bordered dir-table-filter">
								<thead>
									<tr>
										<th>Name</th>
										<th>Extension</th>
                    					<th>Phone</th>
									</tr>
								</thead>

								<tbody id="directory-mia"></tbody>
							</table>
						</div>

            			<!-- External numbers -->
						<div role="tabpanel" class="tab-pane fade" id="external-numbers">
							<table id="directory-ext-table" class="table table-hover table-bordered dir-table-filter">
								<thead>
									<tr>
										<th>Name</th>
										<th>Number</th>
									</tr>
								</thead>

								<tbody id="directory-ext"></tbody>
							</table>
						</div>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
<?php endif ?>
