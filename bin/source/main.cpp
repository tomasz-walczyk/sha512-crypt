/**
 * Copyright (C) 2022 Tomasz Walczyk
 *
 * This software may be modified and distributed under the terms
 * of the GNU LESSER GENERAL PUBLIC LICENSE VERSION 3.0.
 * See the LICENSE file for details.
 */

#include <sha512-crypt/sha512-crypt.hpp>
#include <iostream>
#include <cstdlib>

////////////////////////////////////////////////////////////////////////////////

int main()
{
  std::string password;
  while (std::getline(std::cin, password)) {
    const auto hash = sha512_crypt::sha512_crypt(password);
    if (hash.empty()) {
      std::cerr << "Cannot encrypt a given password!" << std::endl;
      return EXIT_FAILURE;
    } else {
      std::cout << hash << std::endl;
    }
  }
  return EXIT_SUCCESS;
}
