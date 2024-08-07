<?php

namespace Pfy\Cli\Providers;

use Illuminate\Support\ServiceProvider;
use Pfy\Core\Contracts\CommandFactory;
use Pfy\Core\Contracts\Loader;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        $commandLoader = app(Loader::class);

        $commands = $commandLoader->loadCommands()->map(function ($command) {
           return app(CommandFactory::class)->factory($command);
        });

        $this->commands($commands->toArray());
    }

    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }
}
