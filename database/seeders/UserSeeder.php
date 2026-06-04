<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        User::updateOrCreate(
            ['username' => 'superadmin'],
            [
                'password' => 'password',
                'full_name' => 'Super Admin',
                'role' => 'super_admin',
                'status' => 'active',
                'email' => 'admin@school.com',
                'phone' => '012345678',
            ]
        );

        User::updateOrCreate(
            ['username' => 'admin'],
            [
                'password' => 'admin',
                'full_name' => 'Admin User',
                'role' => 'admin',
                'status' => 'active',
                'email' => 'admin2@school.com',
                'phone' => '0987654321',
            ]
        );
    }
}
