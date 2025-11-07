<?php

namespace App\Models;

use CodeIgniter\Model;

class CityModel extends Model
{
    protected $table            = 'cities';
    protected $primaryKey       = 'id';
    protected $useAutoIncrement = true;

    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;

    protected $allowedFields    = [
        'nama_kota',
        'created_at',
        'updated_at',
    ];

    protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';

    protected $validationRules = [
        'nama_kota' => 'required|min_length[3]|max_length[100]',
    ];

    protected $validationMessages = [
        'nama_kota' => [
            'required'   => 'Nama kota wajib diisi.',
            'min_length' => 'Nama kota minimal 3 karakter.',
            'max_length' => 'Nama kota maksimal 100 karakter.',
        ],
    ];

    protected $skipValidation = false;
}