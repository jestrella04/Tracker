<?php foreach ($flashMessages as $type => $flash) : ?>
    <div class="flash-message">
        <div class="alert alert-<?= $type ?> alert-dismissible fade show" role="alert">
            <div class="alert-heading">
                <h5><?= errorType2Text($type) ?></h5>

                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">
                        <i class="fas fa-times"></i>
                    </span>
                </button>
            </div>

            <hr>

            <ul>
                <?php foreach ($flash as $msg) : ?>
                <li><?= $msg ?></li>
                <?php endforeach ?>
            </ul>
        </div>
    </div>
<?php endforeach ?>
