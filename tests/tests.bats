#!/usr/bin/env bats

@test "Opening Transmission on port 9091" {
  skip
  run curl -I -s -X GET http://localhost:9091
  [ "$status" -eq 0 ]
}
