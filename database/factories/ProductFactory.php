<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Product;
use Faker\Generator as Faker;

$factory->define(Product::class, function (Faker $faker) {
    return [
        'title' => $faker->sentence(),
        'desc' => $faker->paragraph(),
        'unit' => 'Container/s',
        'price' => 75000,

    ];
});
