/// \file
/// \addtogroup Postprocess
/// @{
///
// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from postprocess.djinni

#pragma once

#include <bnb/utils/defs.hpp>
#include <cstdint>
#include <memory>
#include <string>

namespace bnb { namespace interfaces {

class postprocess_lut_texture;

/** Used to create resources for postprocess effects. */
class BNB_EXPORT postprocess_helper {
public:
    virtual ~postprocess_helper() {}

    /**
     * Load resources for color filter.
     *
     * @param path_lut_texture path to LUT image. 
     * @return postprocess_lut_texture object that uses for pass parameters to color filter.
     */
    static std::shared_ptr<postprocess_lut_texture> load_color_filter_resources(const std::string & path_lut_texture);

    static void load_glad_functions(int64_t load);
};

} }  // namespace bnb::interfaces
/// @}

