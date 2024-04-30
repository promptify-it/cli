<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use PromptifyIt\PromptifyIt\Contracts\CommandFactory;
use PromptifyIt\PromptifyIt\Contracts\Loader;

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
