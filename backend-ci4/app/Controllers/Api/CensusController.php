<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\CensusModel;
use CodeIgniter\HTTP\ResponseInterface;

class CensusController extends BaseController
{
    protected $censusModel;

    public function __construct()
    {
        $this->censusModel = new CensusModel();
    }

    /**
     * GET /api/census
     * List data sensus + pagination + search nama_penduduk
     * Query: ?page=1&per_page=10&search=budi
     */
    public function index()
    {
        $page    = (int) ($this->request->getGet('page') ?? 1);
        $perPage = (int) ($this->request->getGet('per_page') ?? 10);
        $search  = trim((string) ($this->request->getGet('search') ?? ''));

        if ($perPage < 1) {
            $perPage = 10;
        } elseif ($perPage > 100) {
            $perPage = 100;
        }

        if ($page < 1) {
            $page = 1;
        }

        $offset = ($page - 1) * $perPage;

        // Builder dengan join ke cities untuk dapat nama_kota
        $builder = $this->censusModel->builder();
        $builder->select('sensus.*, cities.nama_kota');
        $builder->join('cities', 'cities.id = sensus.kota_id', 'left');

        if ($search !== '') {
            $builder->like('sensus.nama_penduduk', $search);
        }

        // Clone untuk hitung total
        $totalBuilder = clone $builder;
        $total        = $totalBuilder->countAllResults(false);

        $rows = $builder
            ->orderBy('sensus.id', 'ASC')
            ->limit($perPage, $offset)
            ->get()
            ->getResultArray();

        $totalPages = $perPage > 0 ? (int) ceil($total / $perPage) : 0;

        return $this->respondJson([
            'status' => true,
            'data'   => $rows,
            'meta'   => [
                'page'        => $page,
                'per_page'    => $perPage,
                'total'       => $total,
                'total_pages' => $totalPages,
                'search'      => $search !== '' ? $search : null,
            ],
        ]);
    }

    /**
     * GET /api/census/{id}
     * Detail satu data sensus
     */
    public function show($id = null)
    {
        $id = (int) $id;

        if ($id <= 0) {
            return $this->respondJson([
                'status'  => false,
                'message' => 'ID sensus tidak valid',
            ], ResponseInterface::HTTP_BAD_REQUEST);
        }

        $row = $this->censusModel
            ->select('sensus.*, cities.nama_kota')
            ->join('cities', 'cities.id = sensus.kota_id', 'left')
            ->where('sensus.id', $id)
            ->first();

        if (! $row) {
            return $this->respondJson([
                'status'  => false,
                'message' => 'Data sensus tidak ditemukan',
            ], ResponseInterface::HTTP_NOT_FOUND);
        }

        return $this->respondJson([
            'status' => true,
            'data'   => $row,
        ]);
    }

    /**
     * POST /api/census
     * Body JSON:
     * {
     *   "nik": "3173xxxxxxxx0003",
     *   "nama_penduduk": "Andi Wijaya",
     *   "alamat": "Jl. Melon No. 3",
     *   "kota_id": 2,
     *   "tanggal_input": "2025-10-30"
     * }
     */
    public function store()
    {
        $input = $this->request->getJSON(true) ?: $this->request->getPost();

        if (! $this->censusModel->insert($input)) {
            return $this->respondJson([
                'status'  => false,
                'message' => 'Validasi gagal',
                'errors'  => $this->censusModel->errors(),
            ], ResponseInterface::HTTP_BAD_REQUEST);
        }

        return $this->respondJson([
            'status'  => true,
            'message' => 'Data sensus berhasil disimpan',
            'data'    => [
                'id' => $this->censusModel->getInsertID(),
            ],
        ], ResponseInterface::HTTP_CREATED);
    }

    /**
     * PUT /api/census/{id}
     */
    public function update($id = null)
    {
        $id = (int) $id;

        if ($id <= 0) {
            return $this->respondJson([
                'status'  => false,
                'message' => 'ID sensus tidak valid',
            ], ResponseInterface::HTTP_BAD_REQUEST);
        }

        $existing = $this->censusModel->find($id);

        if (! $existing) {
            return $this->respondJson([
                'status'  => false,
                'message' => 'Data sensus tidak ditemukan',
            ], ResponseInterface::HTTP_NOT_FOUND);
        }

        $input = $this->request->getJSON(true) ?: $this->request->getRawInput();

        if (! $this->censusModel->update($id, $input)) {
            return $this->respondJson([
                'status'  => false,
                'message' => 'Validasi gagal',
                'errors'  => $this->censusModel->errors(),
            ], ResponseInterface::HTTP_BAD_REQUEST);
        }

        return $this->respondJson([
            'status'  => true,
            'message' => 'Data sensus berhasil diperbarui',
        ]);
    }

    /**
     * DELETE /api/census/{id}
     */
    public function delete($id = null)
    {
        $id = (int) $id;

        if ($id <= 0) {
            return $this->respondJson([
                'status'  => false,
                'message' => 'ID sensus tidak valid',
            ], ResponseInterface::HTTP_BAD_REQUEST);
        }

        $existing = $this->censusModel->find($id);

        if (! $existing) {
            return $this->respondJson([
                'status'  => false,
                'message' => 'Data sensus tidak ditemukan',
            ], ResponseInterface::HTTP_NOT_FOUND);
        }

        $this->censusModel->delete($id);

        return $this->respondJson([
            'status'  => true,
            'message' => 'Data sensus berhasil dihapus',
        ]);
    }

    protected function respondJson($body, int $statusCode = 200)
    {
        return service('response')
            ->setStatusCode($statusCode)
            ->setJSON($body);
    }
}