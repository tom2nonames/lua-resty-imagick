-- Copyright (C) by Kwanhur Huang


describe("ImageAttr", function()
    local info = debug.getinfo(1, "S")
    local path = info.source
    path = string.sub(path, 2, -1)
    image_dir = string.match(path, "^.*/")
    image_name = "test_image.png"
    image_filename = image_dir .. image_name 
    
    local imagick = require("resty.imagick")
    
    local img, msg, code = imagick.load_image(image_filename)
    assert.is_true(img ~= nil)
    it("getWidthHeight", function()
        local w = img:get_width()
        local h = img:get_height()

        assert.is_true(w == 64 and h == 64)
    end)

    it("getSetFormat", function()
        local format = img:get_format()
        assert.is_true(format == "png")

        local ok, msg, code = img:set_format('jpeg')
        assert.truthy(ok)
        format = img:get_format()
        assert.is_true(format == "jpeg")
    end)

    it("getSetQuality", function()
        local quality = img:get_quality()
        assert.truthy(quality == 0)
        img:set_quality(75)
        quality = img:get_quality()
        assert.truthy(quality == 75)
    end)
    
    it("getDepth", function()
        local depth = img:get_depth()
        assert.truthy(depth == 8)
    end)

    it("getUnits", function()
        local unit = img:get_units()
        assert.truthy(unit == "PixelsPerCentimeterResolution")
    end)

    it("getSetGravity", function()
        local gravity = img:get_gravity()
        assert.truthy(gravity == "ForgetGravity")

        img:set_gravity("SouthGravity")
        gravity = img:get_gravity()
        assert.truthy(gravity == "SouthGravity")
    end)

    it("getSetColorspace", function()
        local cs = img:get_colorspace()
        assert.is_true(cs == "LuvColorspace")
        
        img:set_colorspace("RGB")
        cs = img:get_colorspace()
        assert.truthy(cs == "RGBColorspace")
    end)

    it("getSetImageType", function()
        local it = img:get_type()
        assert.is_true(it == "TrueColorAlphaType")

        img:set_type("Bilevel")
        it = img:get_type()
        assert.is_true(it == "BilevelType")
    end)

    it("getSetEndian", function()
        local ed = img:get_endian()
        assert.is_true(ed == "UndefinedEndian")

        img:set_endian("LSB")
        ed = img:get_endian()
        assert.is_true(ed == "LSBEndian")
    end)

    it("getSetRendering", function()
        local re = img:get_rendering_intent()
        assert.is_true(re == "PerceptualIntent")

        img:set_rendering_intent("Relative")
        re = img:get_rendering_intent()
        assert.is_true(re == "RelativeIntent")
    end)

    it("getSetGamma", function()
        local ga = img:get_gamma()
        assert.is_true(ga < 0.45455 and ga > 0.45)

        img:set_gamma(0.4)
        ga = img:get_gamma()
        assert.is_true(0.4 == ga)
    end)

    it("getSetInterlaceScheme", function()
        local int = img:get_interlace_scheme()
        assert.is_true( int == "NoInterlace")

        img:set_interlace_scheme("PNG")
        int = img:get_interlace_scheme()
        assert.is_true(int == "PNGInterlace")
    end)

    it("getSetCompose", function()
        local com = img:get_compose()
        assert.is_true(com == "XorCompositeOp")

        img:set_compose("In")
        com = img:get_compose()
        assert.is_true(com == "InCompositeOp")
    end)

    it("getSetCompression", function()
        local com = img:get_compression()
        assert.is_true("ZipCompression" == com)

        img:set_compression("LZW")
        com = img:get_compression()
        assert.is_true("LZWCompression" == com)
    end)

    it("getSetOrientation", function()
        local ori = img:get_orientation()
        assert.is_true("UndefinedOrientation" == ori)

        img:set_orientation("TopLeft")
        ori = img:get_orientation()
        assert.is_true("TopLeftOrientation" == ori)
    end)

    it("getSetDispose", function()
        local dis = img:get_dispose()
        assert.is_true(dis == "UndefinedDispose")

        img:set_dispose("None")
        dis = img:get_dispose()
        assert.is_true(dis == "NoneDispose")
    end)

    it("getSetIterations", function()
        local it = img:get_iterations()
        assert.is_true(it == 0)

        img:set_iterations(1)
        it = img:get_iterations()
        assert.is_true(it == 1)
    end)

    it("getSetPage", function()
        local w, h, x, y = img:get_page()
        assert.is_true(w == 64 and h == 64 and x == 0 and y == 0)

        img:set_page(66, 66, 0, 0)
        w, h, x, y = img:get_page()
        assert.is_true(w == 66)

        img:reset_page()
        w, h, x, y = img:get_page()
        assert.is_true(w == 0 and h == 0 and x == 0 and y == 0)
    end)

    it("getSetFilename", function()
        local fn = img:get_filename()
        assert.is_true(image_filename == fn)

        img:set_filename('spec/test_image.jpg')
        fn = img:get_filename()
        assert.is_true(fn == "spec/test_image.jpg")
    end)

    it("getAlphaChannel", function()
        local ok, msg, code = img:get_alpha_channel()
        assert.is_true(not ok)
    end)

    it("getColors", function()
        local num = img:get_colors()
        assert.is_true(num == 2)
    end)

    it("getSetDelay", function()
        local delay = img:get_delay()
        assert.is_true(0 == delay)

        img:set_delay(1)
        delay = img:get_delay()
        assert.is_true(1 == delay)
    end)

    it("getSetFuzz", function()
        local fuzz = img:get_fuzz()
        assert.is_true(fuzz == 0)

        img:set_fuzz(1)
        fuzz = img:get_fuzz()
        assert.is_true(1 == fuzz)
    end)

    it("getNumber", function()
        local num = img:get_number()
        assert.is_true(num == 1)
    end)

    it("getTotalInkDensity", function()
        local den = img:get_total_ink_density()
        assert.is_true(den == 0)
    end)

    it("getSignature", function()
        local sig = img:get_signature()
        print(sig)
        assert.is_true("0fb068547da285471c32933b16d85663baed20ae49818d61a199d7dc55d1b684" == sig)
    end)

    it("indentify", function()
        local sig = img:identify()
        assert.is_true(string.len(sig) > 0)
    end)
end)
