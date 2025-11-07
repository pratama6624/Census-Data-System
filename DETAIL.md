### Auth End Point

- End Point -> http://localhost:8080/api/auth/login (POST)
- Tanpa JWT (Dapatkan Token)
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/98fdbea3-caf7-40ff-bd6b-5b6f7d3dd3c4" />

- End Point -> http://localhost:8080/api/auth/me (GET)
- Cek berhasil login ke sistem
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/b7bd829f-01cc-4794-9884-85e1d01d6398" />

### City Master End Point

- End Point -> http://localhost:8080/api/cities (GET)
- Dapatkan semua list kota
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/d8f07018-6d7e-4521-a2a8-252f33efa363" />

- End Point -> http://localhost:8080/api/cities?page=1&per_page=10&search=kota& (GET)- Pagination & Search Simulation
- Dapatkan kota dengan parameter pencarian nama kota dengan pagination 10 data / halaman
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/30d41e3f-f526-4165-bc74-5b57f74e5c17" />

- End Point -> http://localhost:8080/api/cities (POST)
- Tambahkan kota
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/35744c75-0deb-44de-8bb2-fe7fbc6b5496" />

- End Point -> http://localhost:8080/api/cities/501 (PUT)
- Update kota
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/75d1f8b5-5ea7-4a57-8d34-c077ab932ba7" />

- End Point -> http://localhost:8080/api/cities/501 (DELETE)
- Hapus kota
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/5ee67b16-1a51-408a-9d07-7cb7c38e5e8b" />

### Census Master End Point

- End Point -> http://localhost:8080/api/census (GET)
- Dapatkan list data sensus
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/429022e4-e57f-4449-b37b-f5094c522678" />

- End Point -> http://localhost:8080/api/census?page=1&per_page=10&search=Penduduk 1 (GET)
- Dapatkan list data sensus dengan parameter pencarian dengan pagination 10 data / halaman
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/7c2af361-0d11-4691-bec1-37f9728c349e" />

- End Point -> http://localhost:8080/api/census/1 (GET)
- Detail data sensus (spesifik ke satu data tertentu)
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/821e0af1-1dc3-4c4e-a778-7d0fab61a41a" />

- End Point -> http://localhost:8080/api/census (POST)
- Tambah data sensus
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/7efa44f4-aab8-420b-9c53-a7d712fa8249" />

- End Point -> http://localhost:8080/api/census/1 (PUT)
- Update data sensus
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/a688a651-c019-4124-93a3-01708c945ae1" />

- End Point -> http://localhost:8080/api/census/1 (DELETE)
- Hapus data sensus
<img width="900" alt="Image" src="https://github.com/user-attachments/assets/aeecc251-0b70-4271-a3fb-bcbf152902de" />