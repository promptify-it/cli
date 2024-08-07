<?php

namespace Pfy\Cli\Commands\Auth;

use LaravelZero\Framework\Commands\Command;
use Pfy\Core\Contracts\Authenticator;

class MeCommand extends Command
{
    /**
     * The signature of the command.
     *
     * @var string
     */
    protected $signature = 'auth:me';

    /**
     * The description of the command.
     *
     * @var string
     */
    protected $description = 'Get the current user';

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $user = app(Authenticator::class)->user();

        $this->info(json_encode($user, JSON_PRETTY_PRINT));

        return 0;
    }
}
