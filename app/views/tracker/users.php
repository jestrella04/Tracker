<div class="card">
    <div class="card-header">
        <h2>
            <span><?= $settings['company_name']['value'] ?> Tracker</span>
            <?php if ($auth->isUserAllowedStatus('On Call')) : ?>
            <button type="button" id ="quicklink-oncall" class="btn btn-default quicklink float-right d-none" title="Pickup this call">
                <i class="fas fa-phone"></i>
            </button>
            <?php endif ?>

            <?php if ($auth->isUserAllowedStatus('Available')) : ?>
            <button type="button" id ="quicklink-available" class="btn btn-default quicklink float-right d-none" title='Change my status back to "Available"'>
                <i class="fas fa-check"></i>
            </button>
            <?php endif ?>
        <h2>
    </div>

    <ul id="active-agents" class="list-group list-group-flush"></ul>
</div>