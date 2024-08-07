<?php

namespace Pfy\Cli\Commands\Auth;

use LaravelZero\Framework\Commands\Command;
use Pfy\Core\Contracts\Authenticator;

use function Laravel\Prompts\password;

class TokenCommand extends Command
{
    /**
     * The signature of the command.
     *
     * @var string
     */
    protected $signature = 'auth:token';

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
        // TODO Add hint on how to get the token
        $token = password('Enter token: ');

        $response = app(Authenticator::class)->authenticate($token);

        if (!$response) {
            $this->error('Invalid token');
            return 1;
        }

        $this->info('Logged in successfully');
    }
}
