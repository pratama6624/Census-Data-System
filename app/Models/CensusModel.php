<?php

namespace App\Models;

use CodeIgniter\Model;

class CensusModel extends Model
{
    protected $table            = 'sensus';
    protected $primaryKey       = 'id';
    protected $useAutoIncrement = true;

    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;

    protected $allowedFields    = [
        'nik',
        'nama_penduduk',
        'alamat',
        'kota_id',
        'tanggal_input',
        'created_at',
        'updated_at',
    ];

    protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';

    protected $validationRules = [
        'nama_penduduk' => 'required|min_length[3]|max_length[150]',
        'kota_id'       => 'required|integer',
        'nik'           => 'permit_empty|min_length[8]|max_length[30]',
        'alamat'        => 'permit_empty',
        'tanggal_input' => 'permit_empty|valid_date[Y-m-d]',
    ];

    protected $validationMessages = [
        'nama_penduduk' => [
            'required'   => 'Nama penduduk wajib diisi.',
            'min_length' => 'Nama penduduk minimal 3 karakter.',
            'max_length' => 'Nama penduduk maksimal 150 karakter.',
        ],
        'kota_id' => [
            'required' => 'Kota wajib diisi.',
            'integer'  => 'Kota tidak valid.',
        ],
        'tanggal_input' => [
            'valid_date' => 'Format tanggal_input harus Y-m-d.',
        ],
    ];

    protected $skipValidation = false;
}