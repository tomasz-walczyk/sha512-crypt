/**
 * Copyright (C) 2022 Tomasz Walczyk
 *
 * This software may be modified and distributed under the terms
 * of the GNU LESSER GENERAL PUBLIC LICENSE VERSION 3.0.
 * See the LICENSE file for details.
 */

#include <string>

namespace sha512_crypt
{
  extern const std::size_t PASSWORD_LENGTH_MAX;
  extern const std::size_t PASSWORD_LENGTH_MIN;
  extern const std::size_t SALT_LENGTH_MAX;
  extern const std::size_t SALT_LENGTH_MIN;
  extern const std::size_t ROUNDS_MAX;
  extern const std::size_t ROUNDS_MIN;
  extern const std::size_t ROUNDS_DEFAULT;

  std::string random_salt();
  std::string sha512_crypt(const std::string& password);
  std::string sha512_crypt(const std::string& password, std::size_t rounds);
  std::string sha512_crypt(const std::string& password, std::size_t rounds, const std::string& salt);
} // namespace sha512_crypt
