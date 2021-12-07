/**
 * Copyright (C) 2022 Tomasz Walczyk
 *
 * This software may be modified and distributed under the terms
 * of the GNU LESSER GENERAL PUBLIC LICENSE VERSION 3.0.
 * See the LICENSE file for details.
 */

#include <sha512-crypt/sha512-crypt.hpp>
#include <gtest/gtest.h>
#include <fstream>
#include <vector>

////////////////////////////////////////////////////////////////////////////////

struct sha512_crypt_test_data
{
  std::string password;
  std::size_t rounds;
  std::string salt;
  std::string hash;
};

////////////////////////////////////////////////////////////////////////////////

std::ostream& operator << (std::ostream& stream, const sha512_crypt_test_data& data)
{
  return stream << data.password
    << ";" << data.rounds
    << ";" << data.salt
    << ";" << data.hash;
}

////////////////////////////////////////////////////////////////////////////////

std::istream& operator >> (std::istream& stream, sha512_crypt_test_data& data)
{
  const auto split = [](const std::string& string) {
    std::vector<std::string> items;
    std::size_t start = 0, end = 0;
    while ((end = string.find(';', start)) != std::string::npos) {
      items.push_back(string.substr(start, end - start));
      start = end + 1;
    }

    items.push_back(string.substr(start));
    return items;
  };

  std::string line;
  data = {};

  if (std::getline(stream, line)) {
    const auto items = split(line);
    if (items.size() != 4) {
      stream.setstate(std::ios_base::failbit);
    } else {
      data.password = items[0];
      data.rounds   = std::atoll(items[1].data());
      data.salt     = items[2];
      data.hash     = items[3];
    }
  }

  return stream;
}

////////////////////////////////////////////////////////////////////////////////

std::vector<sha512_crypt_test_data> load_sha512_crypt_test_data()
{
  std::ifstream file{ std::string{ TEST_DATA_FILE_PATH } };
  if (!file.is_open()) {
    return {};
  }

  std::vector<sha512_crypt_test_data> items;
  sha512_crypt_test_data item = {};

  while (file >> item) {
    items.push_back(item);
  }

  return items;
}

////////////////////////////////////////////////////////////////////////////////

class sha512_crypt_test : public testing::TestWithParam<sha512_crypt_test_data>{};

////////////////////////////////////////////////////////////////////////////////

TEST_P(sha512_crypt_test, sha512_crypt)
{
  const auto& param = GetParam();
  EXPECT_EQ(param.hash, sha512_crypt::sha512_crypt(param.password, param.rounds, param.salt));
}

////////////////////////////////////////////////////////////////////////////////

INSTANTIATE_TEST_SUITE_P(data_from_file, sha512_crypt_test, testing::ValuesIn(load_sha512_crypt_test_data()));
