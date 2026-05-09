/*
 *  Copyright 2026
 *
 *  SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
 */
/*
 *  Description   : HPDcache Victim Buffer skeleton
 */
module hpdcache_vbuf
//  {{{
import hpdcache_pkg::*;
//  Parameters
//  {{{
#(
    parameter hpdcache_cfg_t HPDcacheCfg = '0,

    parameter type hpdcache_nline_t = logic,
    parameter type hpdcache_tag_t = logic,
    parameter type hpdcache_set_t = logic,
    parameter type hpdcache_word_t = logic,
    parameter type hpdcache_way_vector_t = logic,

    parameter type hpdcache_access_data_t = logic,

    parameter type hpdcache_mem_req_t = logic,
    parameter type hpdcache_mem_req_w_t = logic,
    parameter type hpdcache_mem_resp_w_t = logic,

    parameter int unsigned VBUF_DEPTH = 1
)
//  }}}

//  Ports
//  {{{
(
    input  logic                  clk_i,
    input  logic                  rst_ni,

    //      Global control signals
    //      {{{
    output logic                  empty_o,
    output logic                  full_o,
    output logic                  busy_o,
    input  logic                  drain_i,
    //      }}}

    //      CHECK interface
    //      {{{
    input  logic                  check_i,
    input  hpdcache_nline_t       check_nline_i,
    output logic                  check_hit_o,
    //      }}}

    //      ALLOC interface
    //      {{{
    input  logic                  alloc_i,
    output logic                  alloc_ready_o,
    input  hpdcache_nline_t       alloc_nline_i,
    input  hpdcache_tag_t         alloc_tag_i,
    input  hpdcache_set_t         alloc_set_i,
    input  hpdcache_way_vector_t  alloc_way_i,
    //      }}}

    //      CACHE DATA interface
    //      {{{
    output logic                  data_read_o,
    output hpdcache_set_t         data_read_set_o,
    output hpdcache_word_t        data_read_word_o,
    output hpdcache_way_vector_t  data_read_way_o,
    input  hpdcache_access_data_t data_read_data_i,
    output logic                  capture_done_o,
    //      }}}

    //      MEMORY interface
    //      {{{
    input  logic                  mem_req_write_ready_i,
    output logic                  mem_req_write_valid_o,
    output hpdcache_mem_req_t     mem_req_write_o,

    input  logic                  mem_req_write_data_ready_i,
    output logic                  mem_req_write_data_valid_o,
    output hpdcache_mem_req_w_t   mem_req_write_data_o,

    output logic                  mem_resp_write_ready_o,
    input  logic                  mem_resp_write_valid_i,
    input  hpdcache_mem_resp_w_t  mem_resp_write_i
    //      }}}
);
//  }}}

    //  Definition of constants and types
    //  {{{
    localparam int unsigned VbufDepth = VBUF_DEPTH;

    typedef enum logic [2:0] {
        VBUF_IDLE,
        VBUF_ALLOC,
        VBUF_READ_REQ,
        VBUF_READ_WAIT,
        VBUF_READY,
        VBUF_MEM_REQ,
        VBUF_MEM_DATA,
        VBUF_WAIT_RESP
    } vbuf_state_e;

    vbuf_state_e state_q, state_d;
    //  }}}

    //  FSM placeholder
    //  {{{
    always_comb begin
        state_d = VBUF_IDLE;
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin : vbuf_state_ff
        if (!rst_ni) begin
            state_q <= VBUF_IDLE;
        end else begin
            state_q <= state_d;
        end
    end
    //  }}}

    //  Phase 1 tie-offs
    //  {{{
    assign empty_o                    = 1'b1;
    assign full_o                     = 1'b0;
    assign busy_o                     = 1'b0;
    assign alloc_ready_o              = 1'b1;
    assign check_hit_o                = 1'b0;
    assign data_read_o                = 1'b0;
    assign data_read_set_o            = '0;
    assign data_read_word_o           = '0;
    assign data_read_way_o            = '0;
    assign capture_done_o             = 1'b0;
    assign mem_req_write_valid_o      = 1'b0;
    assign mem_req_write_o            = '0;
    assign mem_req_write_data_valid_o = 1'b0;
    assign mem_req_write_data_o       = '0;
    assign mem_resp_write_ready_o     = 1'b0;
    //  }}}

endmodule
//  }}}
