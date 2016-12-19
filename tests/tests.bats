@test "Opening Transmission on port 9091" {
  run curl http://localhost:9091
  [ "${status}" -eq 0 ]
}
