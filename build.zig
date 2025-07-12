const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const abseil_dep = b.dependency("abseil", .{});

    const flags = .{""};

    const abseil = b.addStaticLibrary(.{
        .name = "abseil",
        .target = target,
        .optimize = optimize,
    });
    abseil.linkLibCpp();
    if (target.result.os.tag == .windows) {
        abseil.linkSystemLibrary("dbghelp");
    }
    abseil.addIncludePath(abseil_dep.path("."));
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/base"),
        .files = &.{
            "log_severity.cc",
            "internal/raw_logging.cc",
            "internal/spinlock_wait.cc",
            "internal/low_level_alloc.cc",
            "internal/cycleclock.cc",
            "internal/spinlock.cc",
            "internal/sysinfo.cc",
            "internal/thread_identity.cc",
            "internal/unscaledcycleclock.cc",
            "internal/throw_delegate.cc",
            "internal/scoped_set_env.cc",
            "internal/strerror.cc",
            "internal/poison.cc",
            "internal/tracing.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/container"),
        .files = &.{
            "internal/hashtablez_sampler.cc",
            "internal/hashtablez_sampler_force_weak_definition.cc",
            "internal/raw_hash_set.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/hash"),
        .files = &.{
            "internal/hash.cc",
            "internal/low_level_hash.cc",
            "internal/city.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFile(.{
        .file = abseil_dep.path("absl/numeric/int128.cc"),
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/strings"),
        .files = &.{
            "string_view.cc",
            "ascii.cc",
            "charconv.cc",
            "escaping.cc",
            "internal/charconv_bigint.cc",
            "internal/charconv_parse.cc",
            "internal/damerau_levenshtein_distance.cc",
            "internal/memutil.cc",
            "internal/stringify_sink.cc",
            "match.cc",
            "numbers.cc",
            "str_cat.cc",
            "str_replace.cc",
            "str_split.cc",
            "substitute.cc",
            "internal/escaping.cc",
            "internal/ostringstream.cc",
            "internal/utf8.cc",
            "internal/str_format/arg.cc",
            "internal/str_format/bind.cc",
            "internal/str_format/extension.cc",
            "internal/str_format/float_conversion.cc",
            "internal/str_format/output.cc",
            "internal/str_format/parser.cc",
            "internal/pow10_helper.cc",
            "internal/cord_internal.cc",
            "internal/cord_rep_btree.cc",
            "internal/cord_rep_btree_navigator.cc",
            "internal/cord_rep_btree_reader.cc",
            "internal/cord_rep_crc.cc",
            "internal/cord_rep_consume.cc",
            "internal/cordz_functions.cc",
            "internal/cordz_handle.cc",
            "internal/cordz_info.cc",
            "internal/cordz_sample_token.cc",
            "cord.cc",
            "cord_analysis.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/crc"),
        .files = &.{
            "crc32c.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/debugging"),
        .files = &.{
            "stacktrace.cc",
            "symbolize.cc",
            "internal/examine_stack.cc",
            "failure_signal_handler.cc",
            "internal/address_is_readable.cc",
            "internal/elf_mem_image.cc",
            "internal/vdso_support.cc",
            "internal/demangle.cc",
            "internal/decode_rust_punycode.cc",
            "internal/demangle_rust.cc",
            "internal/utf8_for_code_point.cc",
            "leak_check.cc",
            "internal/stack_consumption.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/flags"),
        .files = &.{
            "internal/program_name.cc",
            "usage_config.cc",
            "marshalling.cc",
            "internal/commandlineflag.cc",
            "commandlineflag.cc",
            "internal/private_handle_accessor.cc",
            "reflection.cc",
            "internal/flag.cc",
            "internal/usage.cc",
            "usage.cc",
            "parse.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/log"),
        .files = &.{
            "internal/check_op.cc",
            "internal/conditions.cc",
            "internal/log_format.cc",
            "internal/globals.cc",
            "internal/proto.cc",
            "internal/log_message.cc",
            "internal/log_sink_set.cc",
            "internal/nullguard.cc",
            "die_if_null.cc",
            "flags.cc",
            "globals.cc",
            "initialize.cc",
            "log_sink.cc",
            "internal/structured_proto.cc",
            "internal/vlog_config.cc",
            "internal/fnmatch.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/profiling"),
        .files = &.{
            "internal/exponential_biased.cc",
            "internal/periodic_sampler.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/random"),
        .files = &.{
            "discrete_distribution.cc",
            "gaussian_distribution.cc",
            "seed_gen_exception.cc",
            "seed_sequences.cc",
            "internal/seed_material.cc",
            "internal/entropy_pool.cc",
            "internal/randen_round_keys.cc",
            "internal/randen.cc",
            "internal/randen_slow.cc",
            "internal/randen_detect.cc",
            "internal/randen_hwaes.cc",
            "internal/chi_square.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/status"),
        .files = &.{
            "internal/status_internal.cc",
            "status.cc",
            "status_payload_printer.cc",
            "statusor.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/synchronization"),
        .files = &.{
            "internal/graphcycles.cc",
            "internal/kernel_timeout.cc",
            "barrier.cc",
            "blocking_counter.cc",
            "internal/create_thread_identity.cc",
            "internal/futex_waiter.cc",
            "internal/per_thread_sem.cc",
            "internal/pthread_waiter.cc",
            "internal/sem_waiter.cc",
            "internal/stdcpp_waiter.cc",
            "internal/waiter_base.cc",
            "internal/win32_waiter.cc",
            "notification.cc",
            "mutex.cc",
        },
        .flags = &flags,
    });
    abseil.addCSourceFiles(.{
        .root = abseil_dep.path("absl/time"),
        .files = &.{
            "civil_time.cc",
            "clock.cc",
            "duration.cc",
            "format.cc",
            "time.cc",
            "internal/cctz/src/civil_time_detail.cc",
            "internal/cctz/src/time_zone_fixed.cc",
            "internal/cctz/src/time_zone_format.cc",
            "internal/cctz/src/time_zone_if.cc",
            "internal/cctz/src/time_zone_impl.cc",
            "internal/cctz/src/time_zone_info.cc",
            "internal/cctz/src/time_zone_libc.cc",
            "internal/cctz/src/time_zone_lookup.cc",
            "internal/cctz/src/time_zone_posix.cc",
            "internal/cctz/src/zone_info_source.cc",
        },
        .flags = &flags,
    });

    abseil.installHeadersDirectory(abseil_dep.path("absl"), "absl", .{ .include_extensions = &.{ "h", "inc" } });
    b.installArtifact(abseil);
}
