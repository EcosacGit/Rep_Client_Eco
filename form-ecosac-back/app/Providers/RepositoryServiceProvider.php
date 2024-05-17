<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;


//Repositorio
use App\Repositories\Form\FormRepository;

//IRepository
use App\Repositories\Form\Contracts\IFormRepository;

//Services
use App\Services\Form\FormService;

//IServices
use App\Services\Form\Contracts\IFormService;


class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(IFormRepository::class, FormRepository::class);
        $this->app->bind(IFormService::class, FormService::class);
    }


    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
